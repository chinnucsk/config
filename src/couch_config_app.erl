% Licensed under the Apache License, Version 2.0 (the "License"); you may not
% use this file except in compliance with the License. You may obtain a copy of
% the License at
%
%   http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
% WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
% License for the specific language governing permissions and limitations under
% the License.

-module(couch_config_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    couch_config_sup:start_link(get_ini_files()).

stop(_State) ->
    ok.

get_ini_files() ->
    Etc = filename:join(code:root_dir(), "etc"),
    Default = [filename:join(Etc,"default.ini"), filename:join(Etc,"local.ini")],
    case application:get_env(couch_config, couch_ini) of
        {ok, Files} -> Files;
        _ -> Default
    end.
