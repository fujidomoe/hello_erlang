-module(hello_erlang_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

%%start(_Type, _Args) ->
%%	hello_erlang_sup:start_link().

start(_Type, _Args) ->
	%% ルートの宣言
	%% {ホストマッチ, [ {パスマッチ, 実行するcowboy_http_handler, [cowboy_http_handlerのオプション] } ]
	Dispatch = cowboy_router:compile([
		{'_', [{"/", hello_handler, []}]}
	]),
	%% httpリスナーを起動
	%% ポートを8080に設定します
	cowboy:start_http(my_http_listener, 100, [{port, 8080}],
		[{env, [{dispatch, Dispatch}]}]
	),
	%% スーパバイザを起動
	hello_erlang_sup:start_link().

stop(_State) ->
	ok.
