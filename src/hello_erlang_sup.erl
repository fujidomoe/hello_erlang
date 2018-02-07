-module(hello_erlang_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
	Procs = [],
	{ok, {{one_for_one, 1, 5}, Procs}}.

start(_Type, _Args) ->
	%% ルートの宣言
	%% {ホストマッチ, [ {パスマッチ, 実行するcowboy_http_handler, [cowboy_http_handlerのオプション] } ]
	Dispatch = cowboy_router:compile([
		{'_', [{"/", hello_handler, []}]}
	]),
	%% httpリスナーを起動
	%% ポート8080に設定します
	cowboy:start_http(my_http_listener, 100, [{port, 8080}],
		{{env, [{dispatch, Dispatch}]}}
	),
	%% スーパバイザを起動
	hello_erlang_sup:start_link().
