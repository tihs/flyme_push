%%%-------------------------------------------------------------------
%%% @doc fmpush main supervisor
%%% @end
%%%-------------------------------------------------------------------
-module(fmpush_sup).

-behaviour(supervisor).

-export([start_link/0, start_connection/1]).
%% API callback
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================
%% @hidden
-spec start_link() ->
  {ok, pid()} | ignore | {error, {already_started, pid()} | shutdown | term()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% @hidden
-spec start_connection(fmpush:connection()) -> {ok, pid()} | {error, term()}.
start_connection(Connection) ->
  supervisor:start_child(?MODULE, [Connection]).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================
%% @hidden
-spec init(_) ->
  {ok,
   {{simple_one_for_one, 999, 1},
    [{connection, {fmpush_connection, start_link, []},
      transient, 5000, worker, [fmpush_connection]}]}}.
init(_) ->
  {ok,
   {{simple_one_for_one, 999, 1},
    [{connection, {fmpush_connection, start_link, []},
      transient, 5000, worker, [fmpush_connection]}]}}.
