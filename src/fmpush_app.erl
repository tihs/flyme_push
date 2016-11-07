-module(fmpush_app).

-behaviour(application).

-export([start/0, stop/0]).

%% Application callbacks
-export([start/2, stop/1]).

-spec start() ->  {'ok', Started} | {'error', Reason} when
  Started :: [atom()],
  Reason :: term().
start() -> application:ensure_all_started(fmpush).
-spec stop() -> 'ok' | {'error', Reason} when
  Reason :: term().
stop() -> application:stop(fmpush).

%% ===================================================================
%% Application callbacks
%% ===================================================================
-spec start(normal | {takeover, node()} | {failover, node()}, term()) ->
  {ok, pid()} | {error, term()}.
start(_StartType, _StartArgs) ->
  fmpush_sup:start_link().

-spec stop(any()) -> ok.
stop(_State) -> ok.
