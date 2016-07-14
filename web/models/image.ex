defmodule Giftrap.Image do
  use Giftrap.Web, :model

  schema "images" do
    field :url, :string
    field :tags, {:array, :string}
    field :clicks, :integer
    field :tag_list, :string, virtual: true
    belongs_to :user, Giftrap.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :tag_list])
    |> validate_required([:url, :tag_list])
    |> filter_tags()
  end
  
  def populate(struct) do
    tag_list = struct.tags |> Enum.join(" ")
    
    %{struct | tag_list: tag_list}
  end
  
  def search(query, term) do
    term
    |> filtered_tags
    |> search_results(query)
  end
    
  def by_user(query, user_id) do
    from i in query,
        where: i.user_id == ^user_id
  end
  
  defp tag_results(result) do
    {columns, rows} = case result do
     {:ok, %{columns: columns, rows: rows}} -> {columns |> Enum.map(&String.to_atom/1) , rows}
      _ -> {[], []}
    end
        
    rows
    |> Enum.map(fn row ->
      Enum.zip(columns, row)
      |> Enum.into(%{})
    end)
  end
  
  def find_tags(search, user_id) do
    Ecto.Adapters.SQL.query(
      Giftrap.Repo, 
      "SELECT * FROM (
        SELECT COUNT(*), UNNEST(tags) AS tag 
          FROM images WHERE user_id = $1 
          GROUP BY tag 
          ORDER BY tag ASC
       ) AS t WHERE t.tag ILIKE $2",
       [user_id, "%#{search}%"]
    )
    |> tag_results
  end
    
  def find_tags(user_id) do
    result = Ecto.Adapters.SQL.query(
      Giftrap.Repo, 
      "SELECT COUNT(*), UNNEST(tags) AS tag FROM images WHERE user_id = $1 GROUP BY tag ORDER BY tag ASC", [user_id]
    )
    
    {columns, rows} = case result do
     {:ok, %{columns: columns, rows: rows}} -> {columns |> Enum.map(&String.to_atom/1) , rows}
      _ -> {[], []}
    end
        
    rows
    |> Enum.map(fn row ->
      Enum.zip(columns, row)
      |> Enum.into(%{})
    end)
  end
  
  defp search_results([], query), do: query
  defp search_results(tag_list, query) do
    from i in query,
      where: fragment("? @> ?", i.tags, ^tag_list)
  end
  
  defp filter_tags(changeset) do
     case changeset do
      %Ecto.Changeset{valid?: true, changes: %{tag_list: tags}} ->
        put_change(changeset, :tags, filtered_tags(tags))
     _ ->
      changeset
    end
  end
  
  defp filtered_tags(tags) when is_binary(tags) do
    tags = String.downcase(tags)
    |> String.replace(~r/[\s,]+/, " ")
    |> String.replace(~r/[^ \p{N}\p{L}_-]+/u, "")
     
    Regex.split(~r/\s+/, tags, trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.uniq
    |> Enum.reject(&(&1 == ""))
    |> Enum.sort
  end
  defp filtered_tags(_tags), do: []
end
