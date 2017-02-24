FROM elixir:1.4.1

WORKDIR /src/gifs

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash \
  && apt-get install -y nodejs \
  && apt-get clean -y \
  && rm -rf /var/cache/apt/*

RUN mix local.hex --force

COPY mix.exs mix.lock /src/gifs/

RUN mix local.rebar --force
RUN mix deps.get

COPY package.json /src/gifs/

RUN npm install

COPY . /src/gifs

CMD mix phoenix.server

EXPOSE 4000
