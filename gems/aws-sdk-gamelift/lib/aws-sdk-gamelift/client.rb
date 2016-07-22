# WARNING ABOUT GENERATED CODE
#
# The AWS SDK for Ruby is largely generated from JSON service definitions. Edits
# made against this file will be lost the next time the SDK updates.  To resolve
# an issue with generated code, a change is likely needed in the generator or
# in one of the service JSON definitions.
#
# * https://github.com/aws/aws-sdk-ruby/tree/master/gems/aws-sdk-code-generator
# * https://github.com/aws/aws-sdk-ruby/tree/master/apis
#
# Open a GitHub issue if you have questions before making changes.  Pull
# requests against this file will be automatically closed.
#
# WARNING ABOUT GENERATED CODE
module Aws
  module GameLift
    class Client < Seahorse::Client::Base

      include Aws::ClientStubs
      include Aws::ClientWaiters

      @identifier = :gamelift

      set_api(ClientApi::API)

      add_plugin(Seahorse::Client::Plugins::ContentLength)
      add_plugin(Aws::Plugins::Logging)
      add_plugin(Aws::Plugins::ParamConverter)
      add_plugin(Aws::Plugins::ParamValidator)
      add_plugin(Aws::Plugins::UserAgent)
      add_plugin(Aws::Plugins::RetryErrors)
      add_plugin(Aws::Plugins::GlobalConfiguration)
      add_plugin(Aws::Plugins::RegionalEndpoint)
      add_plugin(Aws::Plugins::RequestSigner)
      add_plugin(Aws::Plugins::ResponsePaging)
      add_plugin(Aws::Plugins::StubResponses)
      add_plugin(Aws::Plugins::Protocols::JsonRpc)

      # @!group API Operations

      # Creates an alias for a fleet. You can use an alias to anonymize your
      # fleet by referencing an alias instead of a specific fleet when you
      # create game sessions. Amazon GameLift supports two types of routing
      # strategies for aliases: simple and terminal. Use a simple alias to
      # point to an active fleet. Use a terminal alias to display a message to
      # incoming traffic instead of routing players to an active fleet. This
      # option is useful when a game server is no longer supported but you
      # want to provide better messaging than a standard 404 error.
      #
      # To create a fleet alias, specify an alias name, routing strategy, and
      # optional description. If successful, a new alias record is returned,
      # including an alias ID, which you can reference when creating a game
      # session. To reassign the alias to another fleet ID, call UpdateAlias.
      # @option params [required, String] :name
      #   Descriptive label associated with an alias. Alias names do not need to
      #   be unique.
      # @option params [String] :description
      #   Human-readable description of an alias.
      # @option params [required, Types::RoutingStrategy] :routing_strategy
      #   Object specifying the fleet and routing type to use for the alias.
      # @return [Types::CreateAliasOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::CreateAliasOutput#alias #Alias} => Types::Alias
      #
      # @example Request syntax with placeholder values
      #   resp = client.create_alias({
      #     name: "NonZeroAndMaxString", # required
      #     description: "NonZeroAndMaxString",
      #     routing_strategy: { # required
      #       type: "SIMPLE", # accepts SIMPLE, TERMINAL
      #       fleet_id: "FleetId",
      #       message: "FreeText",
      #     },
      #   })
      #
      # @example Response structure
      #   resp.alias.alias_id #=> String
      #   resp.alias.name #=> String
      #   resp.alias.description #=> String
      #   resp.alias.routing_strategy.type #=> String, one of "SIMPLE", "TERMINAL"
      #   resp.alias.routing_strategy.fleet_id #=> String
      #   resp.alias.routing_strategy.message #=> String
      #   resp.alias.creation_time #=> Time
      #   resp.alias.last_updated_time #=> Time
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def create_alias(params = {}, options = {})
        req = build_request(:create_alias, params)
        req.send_request(options)
      end

      # Initializes a new build record and generates information required to
      # upload a game build to Amazon GameLift. Once the build record has been
      # created and is in an `INITIALIZED` state, you can upload your game
      # build.
      #
      # <important markdown="1"> Do not use this API action unless you are using your own Amazon Simple
      # Storage Service (Amazon S3) client and need to manually upload your
      # build files. Instead, to create a build, use the CLI command
      # `upload-build`, which creates a new build record and uploads the build
      # files in one step. (See the [Amazon GameLift Developer Guide][1] for
      # more details on the CLI and the upload process.)
      #
      #  </important>
      #
      # To create a new build, optionally specify a build name and version.
      # This metadata is stored with other properties in the build record and
      # is displayed in the GameLift console (it is not visible to players).
      # If successful, this action returns the newly created build record
      # along with the Amazon S3 storage location and AWS account credentials.
      # Use the location and credentials to upload your game build.
      #
      #
      #
      # [1]: http://docs.aws.amazon.com/gamelift/latest/developerguide/
      # @option params [String] :name
      #   Descriptive label associated with a build. Build names do not need to
      #   be unique. A build name can be changed later using `UpdateBuild`.
      # @option params [String] :version
      #   Version associated with this build. Version strings do not need to be
      #   unique to a build. A build version can be changed later using
      #   `UpdateBuild`.
      # @option params [Types::S3Location] :storage_location
      #   Location in Amazon Simple Storage Service (Amazon S3) where a build\'s
      #   files are stored. This location is assigned in response to a
      #   CreateBuild call, and is always in the same region as the service used
      #   to create the build. For more details see the [Amazon S3
      #   documentation][1].
      #
      #
      #
      #   [1]: http://aws.amazon.com/documentation/s3/
      # @return [Types::CreateBuildOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::CreateBuildOutput#build #Build} => Types::Build
      #   * {Types::CreateBuildOutput#upload_credentials #UploadCredentials} => Types::AwsCredentials
      #   * {Types::CreateBuildOutput#storage_location #StorageLocation} => Types::S3Location
      #
      # @example Request syntax with placeholder values
      #   resp = client.create_build({
      #     name: "NonZeroAndMaxString",
      #     version: "NonZeroAndMaxString",
      #     storage_location: {
      #       bucket: "NonEmptyString",
      #       key: "NonEmptyString",
      #       role_arn: "NonEmptyString",
      #     },
      #   })
      #
      # @example Response structure
      #   resp.build.build_id #=> String
      #   resp.build.name #=> String
      #   resp.build.version #=> String
      #   resp.build.status #=> String, one of "INITIALIZED", "READY", "FAILED"
      #   resp.build.size_on_disk #=> Integer
      #   resp.build.creation_time #=> Time
      #   resp.upload_credentials.access_key_id #=> String
      #   resp.upload_credentials.secret_access_key #=> String
      #   resp.upload_credentials.session_token #=> String
      #   resp.storage_location.bucket #=> String
      #   resp.storage_location.key #=> String
      #   resp.storage_location.role_arn #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def create_build(params = {}, options = {})
        req = build_request(:create_build, params)
        req.send_request(options)
      end

      # Creates a new fleet to run your game servers. A fleet is a set of
      # Amazon Elastic Compute Cloud (Amazon EC2) instances, each of which can
      # run multiple server processes to host game sessions. You configure a
      # fleet to create instances with certain hardware specifications (see
      # [Amazon EC2 Instance Types][1] for more information), and deploy a
      # specified game build to each instance. A newly created fleet passes
      # through several states; once it reaches the `ACTIVE` state, it can
      # begin hosting game sessions.
      #
      # To create a new fleet, provide a fleet name, an EC2 instance type, and
      # a build ID of the game build to deploy. You can also configure the new
      # fleet with the following settings: (1) a runtime configuration
      # describing what server processes to run on each instance in the fleet
      # (required to create fleet), (2) access permissions for inbound
      # traffic, (3) fleet-wide game session protection, and (4) the location
      # of default log files for GameLift to upload and store.
      #
      # If the `CreateFleet` call is successful, Amazon GameLift performs the
      # following tasks:
      #
      # * Creates a fleet record and sets the state to `NEW` (followed by
      #   other states as the fleet is activated).
      # * Sets the fleet\'s capacity to 1 \"desired\", which causes GameLift
      #   to start one new EC2 instance.
      # * Starts launching server processes on the instance. If the fleet is
      #   configured to run multiple server processes per instance, GameLift
      #   staggers each launch by a few seconds.
      # * Begins writing events to the fleet event log, which can be accessed
      #   in the GameLift console.
      # * Sets the fleet\'s status to `ACTIVE` once one server process in the
      #   fleet is ready to host a game session.
      #
      # After a fleet is created, use the following actions to change fleet
      # properties and configuration:
      #
      # * UpdateFleetAttributes -- Update fleet metadata, including name and
      #   description.
      # * UpdateFleetCapacity -- Increase or decrease the number of instances
      #   you want the fleet to maintain.
      # * UpdateFleetPortSettings -- Change the IP address and port ranges
      #   that allow access to incoming traffic.
      # * UpdateRuntimeConfiguration -- Change how server processes are
      #   launched in the fleet, including launch path, launch parameters, and
      #   the number of concurrent processes.
      #
      #
      #
      # [1]: https://aws.amazon.com/ec2/instance-types/
      # @option params [required, String] :name
      #   Descriptive label associated with a fleet. Fleet names do not need to
      #   be unique.
      # @option params [String] :description
      #   Human-readable description of a fleet.
      # @option params [required, String] :build_id
      #   Unique identifier of the build to be deployed on the new fleet. The
      #   build must have been successfully uploaded to GameLift and be in a
      #   `READY` state. This fleet setting cannot be changed once the fleet is
      #   created.
      # @option params [String] :server_launch_path
      #   This parameter is no longer used. Instead, specify a server launch
      #   path using the `RuntimeConfiguration` parameter. (Requests that
      #   specify a server launch path and launch parameters instead of a
      #   runtime configuration will continue to work.)
      # @option params [String] :server_launch_parameters
      #   This parameter is no longer used. Instead, specify server launch
      #   parameters in the `RuntimeConfiguration` parameter. (Requests that
      #   specify a server launch path and launch parameters instead of a
      #   runtime configuration will continue to work.)
      # @option params [Array<String>] :log_paths
      #   Location of default log files. When a server process is shut down,
      #   Amazon GameLift captures and stores any log files in this location.
      #   These logs are in addition to game session logs; see more on game
      #   session logs in the [Amazon GameLift Developer Guide][1]. If no
      #   default log path for a fleet is specified, GameLift will automatically
      #   upload logs stored on each instance at `C:\game\logs`. Use the
      #   GameLift console to access stored logs.
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-api.html#gamelift-sdk-server-api-server-code
      # @option params [required, String] :ec2_instance_type
      #   Name of an EC2 instance type that is supported in Amazon GameLift. A
      #   fleet instance type determines the computing resources of each
      #   instance in the fleet, including CPU, memory, storage, and networking
      #   capacity. GameLift supports the following EC2 instance types. See
      #   [Amazon EC2 Instance Types][1] for detailed descriptions.
      #
      #
      #
      #   [1]: https://aws.amazon.com/ec2/instance-types/
      # @option params [Array<Types::IpPermission>] :ec2_inbound_permissions
      #   Range of IP addresses and port settings that permit inbound traffic to
      #   access server processes running on the fleet. If no inbound
      #   permissions are set, including both IP address range and port range,
      #   the server processes in the fleet cannot accept connections. You can
      #   specify one or more sets of permissions for a fleet.
      # @option params [String] :new_game_session_protection_policy
      #   Game session protection policy to apply to all instances in this
      #   fleet. If this parameter is not set, instances in this fleet default
      #   to no protection. You can change a fleet\'s protection policy using
      #   UpdateFleetAttributes, but this change will only affect sessions
      #   created after the policy change. You can also set protection for
      #   individual instances using UpdateGameSession. * **NoProtection** – The
      #   game session can be terminated during a
      #     scale-down event.
      #   * **FullProtection** – If the game session is in an `ACTIVE` status,
      #     it cannot be terminated during a scale-down event.
      # @option params [Types::RuntimeConfiguration] :runtime_configuration
      #   Instructions for launching server processes on each instance in the
      #   fleet. The runtime configuration for a fleet has a collection of
      #   server process configurations, one for each type of server process to
      #   run on an instance. A server process configuration specifies the
      #   location of the server executable, launch parameters, and the number
      #   of concurrent processes with that configuration to maintain on each
      #   instance. A `CreateFleet` request must include a runtime configuration
      #   with at least one server process configuration; otherwise the request
      #   will fail with an invalid request exception. (This parameter replaces
      #   the parameters `ServerLaunchPath` and `ServerLaunchParameters`;
      #   requests that contain values for these parameters instead of a runtime
      #   configuration will continue to work.)
      # @return [Types::CreateFleetOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::CreateFleetOutput#fleet_attributes #FleetAttributes} => Types::FleetAttributes
      #
      # @example Request syntax with placeholder values
      #   resp = client.create_fleet({
      #     name: "NonZeroAndMaxString", # required
      #     description: "NonZeroAndMaxString",
      #     build_id: "BuildId", # required
      #     server_launch_path: "NonZeroAndMaxString",
      #     server_launch_parameters: "NonZeroAndMaxString",
      #     log_paths: ["NonZeroAndMaxString"],
      #     ec2_instance_type: "t2.micro", # required, accepts t2.micro, t2.small, t2.medium, t2.large, c3.large, c3.xlarge, c3.2xlarge, c3.4xlarge, c3.8xlarge, c4.large, c4.xlarge, c4.2xlarge, c4.4xlarge, c4.8xlarge, r3.large, r3.xlarge, r3.2xlarge, r3.4xlarge, r3.8xlarge, m3.medium, m3.large, m3.xlarge, m3.2xlarge, m4.large, m4.xlarge, m4.2xlarge, m4.4xlarge, m4.10xlarge
      #     ec2_inbound_permissions: [
      #       {
      #         from_port: 1, # required
      #         to_port: 1, # required
      #         ip_range: "NonBlankString", # required
      #         protocol: "TCP", # required, accepts TCP, UDP
      #       },
      #     ],
      #     new_game_session_protection_policy: "NoProtection", # accepts NoProtection, FullProtection
      #     runtime_configuration: {
      #       server_processes: [
      #         {
      #           launch_path: "NonZeroAndMaxString", # required
      #           parameters: "NonZeroAndMaxString",
      #           concurrent_executions: 1, # required
      #         },
      #       ],
      #     },
      #   })
      #
      # @example Response structure
      #   resp.fleet_attributes.fleet_id #=> String
      #   resp.fleet_attributes.description #=> String
      #   resp.fleet_attributes.name #=> String
      #   resp.fleet_attributes.creation_time #=> Time
      #   resp.fleet_attributes.termination_time #=> Time
      #   resp.fleet_attributes.status #=> String, one of "NEW", "DOWNLOADING", "VALIDATING", "BUILDING", "ACTIVATING", "ACTIVE", "DELETING", "ERROR", "TERMINATED"
      #   resp.fleet_attributes.build_id #=> String
      #   resp.fleet_attributes.server_launch_path #=> String
      #   resp.fleet_attributes.server_launch_parameters #=> String
      #   resp.fleet_attributes.log_paths #=> Array
      #   resp.fleet_attributes.log_paths[0] #=> String
      #   resp.fleet_attributes.new_game_session_protection_policy #=> String, one of "NoProtection", "FullProtection"
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def create_fleet(params = {}, options = {})
        req = build_request(:create_fleet, params)
        req.send_request(options)
      end

      # Creates a multiplayer game session for players. This action creates a
      # game session record and assigns the new session to an instance in the
      # specified fleet, which initializes a new server process to host the
      # game session. A fleet must be in an `ACTIVE` state before a game
      # session can be created in it.
      #
      # To create a game session, specify either a fleet ID or an alias ID and
      # indicate the maximum number of players the game session allows. You
      # can also provide a name and a set of properties for your game
      # (optional). If successful, a GameSession object is returned containing
      # session properties, including an IP address. By default, newly created
      # game sessions are set to accept adding any new players to the game
      # session. Use UpdateGameSession to change the creation policy.
      # @option params [String] :fleet_id
      #   Unique identifier for a fleet. Each request must reference either a
      #   fleet ID or alias ID, but not both.
      # @option params [String] :alias_id
      #   Unique identifier for a fleet alias. Each request must reference
      #   either a fleet ID or alias ID, but not both.
      # @option params [required, Integer] :maximum_player_session_count
      #   Maximum number of players that can be connected simultaneously to the
      #   game session.
      # @option params [String] :name
      #   Descriptive label associated with a game session. Session names do not
      #   need to be unique.
      # @option params [Array<Types::GameProperty>] :game_properties
      #   Set of properties used to administer a game session. These properties
      #   are passed to the server process hosting it.
      # @return [Types::CreateGameSessionOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::CreateGameSessionOutput#game_session #GameSession} => Types::GameSession
      #
      # @example Request syntax with placeholder values
      #   resp = client.create_game_session({
      #     fleet_id: "FleetId",
      #     alias_id: "AliasId",
      #     maximum_player_session_count: 1, # required
      #     name: "NonZeroAndMaxString",
      #     game_properties: [
      #       {
      #         key: "GamePropertyKey", # required
      #         value: "GamePropertyValue", # required
      #       },
      #     ],
      #   })
      #
      # @example Response structure
      #   resp.game_session.game_session_id #=> String
      #   resp.game_session.name #=> String
      #   resp.game_session.fleet_id #=> String
      #   resp.game_session.creation_time #=> Time
      #   resp.game_session.termination_time #=> Time
      #   resp.game_session.current_player_session_count #=> Integer
      #   resp.game_session.maximum_player_session_count #=> Integer
      #   resp.game_session.status #=> String, one of "ACTIVE", "ACTIVATING", "TERMINATED", "TERMINATING"
      #   resp.game_session.game_properties #=> Array
      #   resp.game_session.game_properties[0].key #=> String
      #   resp.game_session.game_properties[0].value #=> String
      #   resp.game_session.ip_address #=> String
      #   resp.game_session.port #=> Integer
      #   resp.game_session.player_session_creation_policy #=> String, one of "ACCEPT_ALL", "DENY_ALL"
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def create_game_session(params = {}, options = {})
        req = build_request(:create_game_session, params)
        req.send_request(options)
      end

      # Adds a player to a game session and creates a player session record. A
      # game session must be in an `ACTIVE` state, have a creation policy of
      # `ALLOW_ALL`, and have an open player slot before players can be added
      # to the session.
      #
      # To create a player session, specify a game session ID and player ID.
      # If successful, the player is added to the game session and a new
      # PlayerSession object is returned.
      # @option params [required, String] :game_session_id
      #   Unique identifier for a game session. Specify the game session you
      #   want to add a player to.
      # @option params [required, String] :player_id
      #   Unique identifier for the player to be added.
      # @return [Types::CreatePlayerSessionOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::CreatePlayerSessionOutput#player_session #PlayerSession} => Types::PlayerSession
      #
      # @example Request syntax with placeholder values
      #   resp = client.create_player_session({
      #     game_session_id: "GameSessionId", # required
      #     player_id: "NonZeroAndMaxString", # required
      #   })
      #
      # @example Response structure
      #   resp.player_session.player_session_id #=> String
      #   resp.player_session.player_id #=> String
      #   resp.player_session.game_session_id #=> String
      #   resp.player_session.fleet_id #=> String
      #   resp.player_session.creation_time #=> Time
      #   resp.player_session.termination_time #=> Time
      #   resp.player_session.status #=> String, one of "RESERVED", "ACTIVE", "COMPLETED", "TIMEDOUT"
      #   resp.player_session.ip_address #=> String
      #   resp.player_session.port #=> Integer
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def create_player_session(params = {}, options = {})
        req = build_request(:create_player_session, params)
        req.send_request(options)
      end

      # Adds a group of players to a game session. Similar to
      # CreatePlayerSession, this action allows you to add multiple players in
      # a single call, which is useful for games that provide party and/or
      # matchmaking features. A game session must be in an `ACTIVE` state,
      # have a creation policy of `ALLOW_ALL`, and have an open player slot
      # before players can be added to the session.
      #
      # To create player sessions, specify a game session ID and a list of
      # player IDs. If successful, the players are added to the game session
      # and a set of new PlayerSession objects is returned.
      # @option params [required, String] :game_session_id
      #   Unique identifier for a game session.
      # @option params [required, Array<String>] :player_ids
      #   List of unique identifiers for the players to be added.
      # @return [Types::CreatePlayerSessionsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::CreatePlayerSessionsOutput#player_sessions #PlayerSessions} => Array&lt;Types::PlayerSession&gt;
      #
      # @example Request syntax with placeholder values
      #   resp = client.create_player_sessions({
      #     game_session_id: "GameSessionId", # required
      #     player_ids: ["NonZeroAndMaxString"], # required
      #   })
      #
      # @example Response structure
      #   resp.player_sessions #=> Array
      #   resp.player_sessions[0].player_session_id #=> String
      #   resp.player_sessions[0].player_id #=> String
      #   resp.player_sessions[0].game_session_id #=> String
      #   resp.player_sessions[0].fleet_id #=> String
      #   resp.player_sessions[0].creation_time #=> Time
      #   resp.player_sessions[0].termination_time #=> Time
      #   resp.player_sessions[0].status #=> String, one of "RESERVED", "ACTIVE", "COMPLETED", "TIMEDOUT"
      #   resp.player_sessions[0].ip_address #=> String
      #   resp.player_sessions[0].port #=> Integer
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def create_player_sessions(params = {}, options = {})
        req = build_request(:create_player_sessions, params)
        req.send_request(options)
      end

      # Deletes an alias. This action removes all record of the alias; game
      # clients attempting to access a server process using the deleted alias
      # receive an error. To delete an alias, specify the alias ID to be
      # deleted.
      # @option params [required, String] :alias_id
      #   Unique identifier for a fleet alias. Specify the alias you want to
      #   delete.
      # @return [Struct] Returns an empty {Seahorse::Client::Response response}.
      #
      # @example Request syntax with placeholder values
      #   resp = client.delete_alias({
      #     alias_id: "AliasId", # required
      #   })
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def delete_alias(params = {}, options = {})
        req = build_request(:delete_alias, params)
        req.send_request(options)
      end

      # Deletes a build. This action permanently deletes the build record and
      # any uploaded build files.
      #
      # To delete a build, specify its ID. Deleting a build does not affect
      # the status of any active fleets using the build, but you can no longer
      # create new fleets with the deleted build.
      # @option params [required, String] :build_id
      #   Unique identifier for the build you want to delete.
      # @return [Struct] Returns an empty {Seahorse::Client::Response response}.
      #
      # @example Request syntax with placeholder values
      #   resp = client.delete_build({
      #     build_id: "BuildId", # required
      #   })
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def delete_build(params = {}, options = {})
        req = build_request(:delete_build, params)
        req.send_request(options)
      end

      # Deletes everything related to a fleet. Before deleting a fleet, you
      # must set the fleet\'s desired capacity to zero. See
      # UpdateFleetCapacity.
      #
      # This action removes the fleet\'s resources and the fleet record. Once
      # a fleet is deleted, you can no longer use that fleet.
      # @option params [required, String] :fleet_id
      #   Unique identifier for the fleet you want to delete.
      # @return [Struct] Returns an empty {Seahorse::Client::Response response}.
      #
      # @example Request syntax with placeholder values
      #   resp = client.delete_fleet({
      #     fleet_id: "FleetId", # required
      #   })
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def delete_fleet(params = {}, options = {})
        req = build_request(:delete_fleet, params)
        req.send_request(options)
      end

      # Deletes a fleet scaling policy. This action means that the policy is
      # no longer in force and removes all record of it. To delete a scaling
      # policy, specify both the scaling policy name and the fleet ID it is
      # associated with.
      # @option params [required, String] :name
      #   Descriptive label associated with a scaling policy. Policy names do
      #   not need to be unique.
      # @option params [required, String] :fleet_id
      #   Unique identifier for a fleet.
      # @return [Struct] Returns an empty {Seahorse::Client::Response response}.
      #
      # @example Request syntax with placeholder values
      #   resp = client.delete_scaling_policy({
      #     name: "NonZeroAndMaxString", # required
      #     fleet_id: "FleetId", # required
      #   })
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def delete_scaling_policy(params = {}, options = {})
        req = build_request(:delete_scaling_policy, params)
        req.send_request(options)
      end

      # Retrieves properties for a specified alias. To get the alias, specify
      # an alias ID. If successful, an Alias object is returned.
      # @option params [required, String] :alias_id
      #   Unique identifier for a fleet alias. Specify the alias you want to
      #   retrieve.
      # @return [Types::DescribeAliasOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeAliasOutput#alias #Alias} => Types::Alias
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_alias({
      #     alias_id: "AliasId", # required
      #   })
      #
      # @example Response structure
      #   resp.alias.alias_id #=> String
      #   resp.alias.name #=> String
      #   resp.alias.description #=> String
      #   resp.alias.routing_strategy.type #=> String, one of "SIMPLE", "TERMINAL"
      #   resp.alias.routing_strategy.fleet_id #=> String
      #   resp.alias.routing_strategy.message #=> String
      #   resp.alias.creation_time #=> Time
      #   resp.alias.last_updated_time #=> Time
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_alias(params = {}, options = {})
        req = build_request(:describe_alias, params)
        req.send_request(options)
      end

      # Retrieves properties for a build. To get a build record, specify a
      # build ID. If successful, an object containing the build properties is
      # returned.
      # @option params [required, String] :build_id
      #   Unique identifier of the build that you want to retrieve properties
      #   for.
      # @return [Types::DescribeBuildOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeBuildOutput#build #Build} => Types::Build
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_build({
      #     build_id: "BuildId", # required
      #   })
      #
      # @example Response structure
      #   resp.build.build_id #=> String
      #   resp.build.name #=> String
      #   resp.build.version #=> String
      #   resp.build.status #=> String, one of "INITIALIZED", "READY", "FAILED"
      #   resp.build.size_on_disk #=> Integer
      #   resp.build.creation_time #=> Time
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_build(params = {}, options = {})
        req = build_request(:describe_build, params)
        req.send_request(options)
      end

      # Retrieves the following information for the specified EC2 instance
      # type:
      #
      # * maximum number of instances allowed per AWS account (service limit)
      # * current usage level for the AWS account
      #
      # Service limits vary depending on region. Available regions for
      # GameLift can be found in the AWS Management Console for GameLift (see
      # the drop-down list in the upper right corner).
      # @option params [String] :ec2_instance_type
      #   Name of an EC2 instance type that is supported in Amazon GameLift. A
      #   fleet instance type determines the computing resources of each
      #   instance in the fleet, including CPU, memory, storage, and networking
      #   capacity. GameLift supports the following EC2 instance types. See
      #   [Amazon EC2 Instance Types][1] for detailed descriptions. Leave this
      #   parameter blank to retrieve limits for all types.
      #
      #
      #
      #   [1]: https://aws.amazon.com/ec2/instance-types/
      # @return [Types::DescribeEC2InstanceLimitsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeEC2InstanceLimitsOutput#ec2_instance_limits #EC2InstanceLimits} => Array&lt;Types::EC2InstanceLimit&gt;
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_ec2_instance_limits({
      #     ec2_instance_type: "t2.micro", # accepts t2.micro, t2.small, t2.medium, t2.large, c3.large, c3.xlarge, c3.2xlarge, c3.4xlarge, c3.8xlarge, c4.large, c4.xlarge, c4.2xlarge, c4.4xlarge, c4.8xlarge, r3.large, r3.xlarge, r3.2xlarge, r3.4xlarge, r3.8xlarge, m3.medium, m3.large, m3.xlarge, m3.2xlarge, m4.large, m4.xlarge, m4.2xlarge, m4.4xlarge, m4.10xlarge
      #   })
      #
      # @example Response structure
      #   resp.ec2_instance_limits #=> Array
      #   resp.ec2_instance_limits[0].ec2_instance_type #=> String, one of "t2.micro", "t2.small", "t2.medium", "t2.large", "c3.large", "c3.xlarge", "c3.2xlarge", "c3.4xlarge", "c3.8xlarge", "c4.large", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "c4.8xlarge", "r3.large", "r3.xlarge", "r3.2xlarge", "r3.4xlarge", "r3.8xlarge", "m3.medium", "m3.large", "m3.xlarge", "m3.2xlarge", "m4.large", "m4.xlarge", "m4.2xlarge", "m4.4xlarge", "m4.10xlarge"
      #   resp.ec2_instance_limits[0].current_instances #=> Integer
      #   resp.ec2_instance_limits[0].instance_limit #=> Integer
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_ec2_instance_limits(params = {}, options = {})
        req = build_request(:describe_ec2_instance_limits, params)
        req.send_request(options)
      end

      # Retrieves fleet properties, including metadata, status, and
      # configuration, for one or more fleets. You can request attributes for
      # all fleets, or specify a list of one or more fleet IDs. When
      # requesting multiple fleets, use the pagination parameters to retrieve
      # results as a set of sequential pages. If successful, a FleetAttributes
      # object is returned for each requested fleet ID. When specifying a list
      # of fleet IDs, attribute objects are returned only for fleets that
      # currently exist.
      #
      # <note markdown="1"> Some API actions may limit the number of fleet IDs allowed in one
      # request. If a request exceeds this limit, the request fails and the
      # error message includes the maximum allowed.
      #
      #  </note>
      # @option params [Array<String>] :fleet_ids
      #   Unique identifiers for the fleet(s) that you want to retrieve
      #   attributes for. To request attributes for all fleets, leave this
      #   parameter empty.
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages. This
      #   parameter is ignored when the request specifies one or a list of fleet
      #   IDs.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value. This
      #   parameter is ignored when the request specifies one or a list of fleet
      #   IDs.
      # @return [Types::DescribeFleetAttributesOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeFleetAttributesOutput#fleet_attributes #FleetAttributes} => Array&lt;Types::FleetAttributes&gt;
      #   * {Types::DescribeFleetAttributesOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_fleet_attributes({
      #     fleet_ids: ["FleetId"],
      #     limit: 1,
      #     next_token: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.fleet_attributes #=> Array
      #   resp.fleet_attributes[0].fleet_id #=> String
      #   resp.fleet_attributes[0].description #=> String
      #   resp.fleet_attributes[0].name #=> String
      #   resp.fleet_attributes[0].creation_time #=> Time
      #   resp.fleet_attributes[0].termination_time #=> Time
      #   resp.fleet_attributes[0].status #=> String, one of "NEW", "DOWNLOADING", "VALIDATING", "BUILDING", "ACTIVATING", "ACTIVE", "DELETING", "ERROR", "TERMINATED"
      #   resp.fleet_attributes[0].build_id #=> String
      #   resp.fleet_attributes[0].server_launch_path #=> String
      #   resp.fleet_attributes[0].server_launch_parameters #=> String
      #   resp.fleet_attributes[0].log_paths #=> Array
      #   resp.fleet_attributes[0].log_paths[0] #=> String
      #   resp.fleet_attributes[0].new_game_session_protection_policy #=> String, one of "NoProtection", "FullProtection"
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_fleet_attributes(params = {}, options = {})
        req = build_request(:describe_fleet_attributes, params)
        req.send_request(options)
      end

      # Retrieves the current status of fleet capacity for one or more fleets.
      # This information includes the number of instances that have been
      # requested for the fleet and the number currently active. You can
      # request capacity for all fleets, or specify a list of one or more
      # fleet IDs. When requesting multiple fleets, use the pagination
      # parameters to retrieve results as a set of sequential pages. If
      # successful, a FleetCapacity object is returned for each requested
      # fleet ID. When specifying a list of fleet IDs, attribute objects are
      # returned only for fleets that currently exist.
      #
      # <note markdown="1"> Some API actions may limit the number of fleet IDs allowed in one
      # request. If a request exceeds this limit, the request fails and the
      # error message includes the maximum allowed.
      #
      #  </note>
      # @option params [Array<String>] :fleet_ids
      #   Unique identifier for the fleet(s) you want to retrieve capacity
      #   information for. To request capacity information for all fleets, leave
      #   this parameter empty.
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages. This
      #   parameter is ignored when the request specifies one or a list of fleet
      #   IDs.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value. This
      #   parameter is ignored when the request specifies one or a list of fleet
      #   IDs.
      # @return [Types::DescribeFleetCapacityOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeFleetCapacityOutput#fleet_capacity #FleetCapacity} => Array&lt;Types::FleetCapacity&gt;
      #   * {Types::DescribeFleetCapacityOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_fleet_capacity({
      #     fleet_ids: ["FleetId"],
      #     limit: 1,
      #     next_token: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.fleet_capacity #=> Array
      #   resp.fleet_capacity[0].fleet_id #=> String
      #   resp.fleet_capacity[0].instance_type #=> String, one of "t2.micro", "t2.small", "t2.medium", "t2.large", "c3.large", "c3.xlarge", "c3.2xlarge", "c3.4xlarge", "c3.8xlarge", "c4.large", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "c4.8xlarge", "r3.large", "r3.xlarge", "r3.2xlarge", "r3.4xlarge", "r3.8xlarge", "m3.medium", "m3.large", "m3.xlarge", "m3.2xlarge", "m4.large", "m4.xlarge", "m4.2xlarge", "m4.4xlarge", "m4.10xlarge"
      #   resp.fleet_capacity[0].instance_counts.desired #=> Integer
      #   resp.fleet_capacity[0].instance_counts.minimum #=> Integer
      #   resp.fleet_capacity[0].instance_counts.maximum #=> Integer
      #   resp.fleet_capacity[0].instance_counts.pending #=> Integer
      #   resp.fleet_capacity[0].instance_counts.active #=> Integer
      #   resp.fleet_capacity[0].instance_counts.idle #=> Integer
      #   resp.fleet_capacity[0].instance_counts.terminating #=> Integer
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_fleet_capacity(params = {}, options = {})
        req = build_request(:describe_fleet_capacity, params)
        req.send_request(options)
      end

      # Retrieves entries from the specified fleet\'s event log. You can
      # specify a time range to limit the result set. Use the pagination
      # parameters to retrieve results as a set of sequential pages. If
      # successful, a collection of event log entries matching the request are
      # returned.
      # @option params [required, String] :fleet_id
      #   Unique identifier for the fleet to get event logs for.
      # @option params [Time,DateTime,Date,Integer,String] :start_time
      #   Earliest date to retrieve event logs for. If no start time is
      #   specified, this call returns entries starting from when the fleet was
      #   created to the specified end time. Format is an integer representing
      #   the number of seconds since the Unix epoch (Unix time).
      # @option params [Time,DateTime,Date,Integer,String] :end_time
      #   Most recent date to retrieve event logs for. If no end time is
      #   specified, this call returns entries from the specified start time up
      #   to the present. Format is an integer representing the number of
      #   seconds since the Unix epoch (Unix time).
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value.
      # @return [Types::DescribeFleetEventsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeFleetEventsOutput#events #Events} => Array&lt;Types::Event&gt;
      #   * {Types::DescribeFleetEventsOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_fleet_events({
      #     fleet_id: "FleetId", # required
      #     start_time: Time.now,
      #     end_time: Time.now,
      #     limit: 1,
      #     next_token: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.events #=> Array
      #   resp.events[0].event_id #=> String
      #   resp.events[0].resource_id #=> String
      #   resp.events[0].event_code #=> String, one of "GENERIC_EVENT", "FLEET_CREATED", "FLEET_DELETED", "FLEET_SCALING_EVENT", "FLEET_STATE_DOWNLOADING", "FLEET_STATE_VALIDATING", "FLEET_STATE_BUILDING", "FLEET_STATE_ACTIVATING", "FLEET_STATE_ACTIVE", "FLEET_STATE_ERROR", "FLEET_INITIALIZATION_FAILED", "FLEET_BINARY_DOWNLOAD_FAILED", "FLEET_VALIDATION_LAUNCH_PATH_NOT_FOUND", "FLEET_VALIDATION_EXECUTABLE_RUNTIME_FAILURE", "FLEET_VALIDATION_TIMED_OUT", "FLEET_ACTIVATION_FAILED", "FLEET_ACTIVATION_FAILED_NO_INSTANCES", "FLEET_NEW_GAME_SESSION_PROTECTION_POLICY_UPDATED"
      #   resp.events[0].message #=> String
      #   resp.events[0].event_time #=> Time
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_fleet_events(params = {}, options = {})
        req = build_request(:describe_fleet_events, params)
        req.send_request(options)
      end

      # Retrieves the inbound connection permissions for a fleet. Connection
      # permissions include a range of IP addresses and port settings that
      # incoming traffic can use to access server processes in the fleet. To
      # get a fleet\'s inbound connection permissions, specify a fleet ID. If
      # successful, a collection of IpPermission objects is returned for the
      # requested fleet ID. If the requested fleet has been deleted, the
      # result set is empty.
      # @option params [required, String] :fleet_id
      #   Unique identifier for the fleet you want to retrieve port settings
      #   for.
      # @return [Types::DescribeFleetPortSettingsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeFleetPortSettingsOutput#inbound_permissions #InboundPermissions} => Array&lt;Types::IpPermission&gt;
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_fleet_port_settings({
      #     fleet_id: "FleetId", # required
      #   })
      #
      # @example Response structure
      #   resp.inbound_permissions #=> Array
      #   resp.inbound_permissions[0].from_port #=> Integer
      #   resp.inbound_permissions[0].to_port #=> Integer
      #   resp.inbound_permissions[0].ip_range #=> String
      #   resp.inbound_permissions[0].protocol #=> String, one of "TCP", "UDP"
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_fleet_port_settings(params = {}, options = {})
        req = build_request(:describe_fleet_port_settings, params)
        req.send_request(options)
      end

      # Retrieves utilization statistics for one or more fleets. You can
      # request utilization data for all fleets, or specify a list of one or
      # more fleet IDs. When requesting multiple fleets, use the pagination
      # parameters to retrieve results as a set of sequential pages. If
      # successful, a FleetUtilization object is returned for each requested
      # fleet ID. When specifying a list of fleet IDs, utilization objects are
      # returned only for fleets that currently exist.
      #
      # <note markdown="1"> Some API actions may limit the number of fleet IDs allowed in one
      # request. If a request exceeds this limit, the request fails and the
      # error message includes the maximum allowed.
      #
      #  </note>
      # @option params [Array<String>] :fleet_ids
      #   Unique identifier for the fleet(s) you want to retrieve utilization
      #   data for. To request utilization data for all fleets, leave this
      #   parameter empty.
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages. This
      #   parameter is ignored when the request specifies one or a list of fleet
      #   IDs.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value. This
      #   parameter is ignored when the request specifies one or a list of fleet
      #   IDs.
      # @return [Types::DescribeFleetUtilizationOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeFleetUtilizationOutput#fleet_utilization #FleetUtilization} => Array&lt;Types::FleetUtilization&gt;
      #   * {Types::DescribeFleetUtilizationOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_fleet_utilization({
      #     fleet_ids: ["FleetId"],
      #     limit: 1,
      #     next_token: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.fleet_utilization #=> Array
      #   resp.fleet_utilization[0].fleet_id #=> String
      #   resp.fleet_utilization[0].active_server_process_count #=> Integer
      #   resp.fleet_utilization[0].active_game_session_count #=> Integer
      #   resp.fleet_utilization[0].current_player_session_count #=> Integer
      #   resp.fleet_utilization[0].maximum_player_session_count #=> Integer
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_fleet_utilization(params = {}, options = {})
        req = build_request(:describe_fleet_utilization, params)
        req.send_request(options)
      end

      # Retrieves properties, including the protection policy in force, for
      # one or more game sessions. This action can be used in several ways:
      # (1) provide a `GameSessionId` to request details for a specific game
      # session; (2) provide either a `FleetId` or an `AliasId` to request
      # properties for all game sessions running on a fleet.
      #
      # To get game session record(s), specify just one of the following: game
      # session ID, fleet ID, or alias ID. You can filter this request by game
      # session status. Use the pagination parameters to retrieve results as a
      # set of sequential pages. If successful, a GameSessionDetail object is
      # returned for each session matching the request.
      # @option params [String] :fleet_id
      #   Unique identifier for a fleet. Specify a fleet to retrieve information
      #   on all game sessions active on the fleet.
      # @option params [String] :game_session_id
      #   Unique identifier for a game session. Specify the game session to
      #   retrieve information on.
      # @option params [String] :alias_id
      #   Unique identifier for a fleet alias. Specify an alias to retrieve
      #   information on all game sessions active on the fleet.
      # @option params [String] :status_filter
      #   Game session status to filter results on. Possible game session states
      #   include ACTIVE, `TERMINATED`, `ACTIVATING` and `TERMINATING` (the last
      #   two are transitory).
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value.
      # @return [Types::DescribeGameSessionDetailsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeGameSessionDetailsOutput#game_session_details #GameSessionDetails} => Array&lt;Types::GameSessionDetail&gt;
      #   * {Types::DescribeGameSessionDetailsOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_game_session_details({
      #     fleet_id: "FleetId",
      #     game_session_id: "GameSessionId",
      #     alias_id: "AliasId",
      #     status_filter: "NonZeroAndMaxString",
      #     limit: 1,
      #     next_token: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.game_session_details #=> Array
      #   resp.game_session_details[0].game_session.game_session_id #=> String
      #   resp.game_session_details[0].game_session.name #=> String
      #   resp.game_session_details[0].game_session.fleet_id #=> String
      #   resp.game_session_details[0].game_session.creation_time #=> Time
      #   resp.game_session_details[0].game_session.termination_time #=> Time
      #   resp.game_session_details[0].game_session.current_player_session_count #=> Integer
      #   resp.game_session_details[0].game_session.maximum_player_session_count #=> Integer
      #   resp.game_session_details[0].game_session.status #=> String, one of "ACTIVE", "ACTIVATING", "TERMINATED", "TERMINATING"
      #   resp.game_session_details[0].game_session.game_properties #=> Array
      #   resp.game_session_details[0].game_session.game_properties[0].key #=> String
      #   resp.game_session_details[0].game_session.game_properties[0].value #=> String
      #   resp.game_session_details[0].game_session.ip_address #=> String
      #   resp.game_session_details[0].game_session.port #=> Integer
      #   resp.game_session_details[0].game_session.player_session_creation_policy #=> String, one of "ACCEPT_ALL", "DENY_ALL"
      #   resp.game_session_details[0].protection_policy #=> String, one of "NoProtection", "FullProtection"
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_game_session_details(params = {}, options = {})
        req = build_request(:describe_game_session_details, params)
        req.send_request(options)
      end

      # Retrieves properties for one or more game sessions. This action can be
      # used in several ways: (1) provide a `GameSessionId` to request
      # properties for a specific game session; (2) provide a `FleetId` or an
      # `AliasId` to request properties for all game sessions running on a
      # fleet.
      #
      # To get game session record(s), specify just one of the following: game
      # session ID, fleet ID, or alias ID. You can filter this request by game
      # session status. Use the pagination parameters to retrieve results as a
      # set of sequential pages. If successful, a GameSession object is
      # returned for each session matching the request.
      # @option params [String] :fleet_id
      #   Unique identifier for a fleet. Specify a fleet to retrieve information
      #   on all game sessions active on the fleet.
      # @option params [String] :game_session_id
      #   Unique identifier for a game session. Specify the game session to
      #   retrieve information on.
      # @option params [String] :alias_id
      #   Unique identifier for a fleet alias. Specify an alias to retrieve
      #   information on all game sessions active on the fleet.
      # @option params [String] :status_filter
      #   Game session status to filter results on. Possible game session states
      #   include `ACTIVE`, `TERMINATED`, `ACTIVATING`, and `TERMINATING` (the
      #   last two are transitory).
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value.
      # @return [Types::DescribeGameSessionsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeGameSessionsOutput#game_sessions #GameSessions} => Array&lt;Types::GameSession&gt;
      #   * {Types::DescribeGameSessionsOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_game_sessions({
      #     fleet_id: "FleetId",
      #     game_session_id: "GameSessionId",
      #     alias_id: "AliasId",
      #     status_filter: "NonZeroAndMaxString",
      #     limit: 1,
      #     next_token: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.game_sessions #=> Array
      #   resp.game_sessions[0].game_session_id #=> String
      #   resp.game_sessions[0].name #=> String
      #   resp.game_sessions[0].fleet_id #=> String
      #   resp.game_sessions[0].creation_time #=> Time
      #   resp.game_sessions[0].termination_time #=> Time
      #   resp.game_sessions[0].current_player_session_count #=> Integer
      #   resp.game_sessions[0].maximum_player_session_count #=> Integer
      #   resp.game_sessions[0].status #=> String, one of "ACTIVE", "ACTIVATING", "TERMINATED", "TERMINATING"
      #   resp.game_sessions[0].game_properties #=> Array
      #   resp.game_sessions[0].game_properties[0].key #=> String
      #   resp.game_sessions[0].game_properties[0].value #=> String
      #   resp.game_sessions[0].ip_address #=> String
      #   resp.game_sessions[0].port #=> Integer
      #   resp.game_sessions[0].player_session_creation_policy #=> String, one of "ACCEPT_ALL", "DENY_ALL"
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_game_sessions(params = {}, options = {})
        req = build_request(:describe_game_sessions, params)
        req.send_request(options)
      end

      # Retrieves properties for one or more player sessions. This action can
      # be used in several ways: (1) provide a `PlayerSessionId` parameter to
      # request properties for a specific player session; (2) provide a
      # `GameSessionId` parameter to request properties for all player
      # sessions in the specified game session; (3) provide a `PlayerId`
      # parameter to request properties for all player sessions of a specified
      # player.
      #
      # To get game session record(s), specify only one of the following: a
      # player session ID, a game session ID, or a player ID. You can filter
      # this request by player session status. Use the pagination parameters
      # to retrieve results as a set of sequential pages. If successful, a
      # PlayerSession object is returned for each session matching the
      # request.
      # @option params [String] :game_session_id
      #   Unique identifier for a game session.
      # @option params [String] :player_id
      #   Unique identifier for a player.
      # @option params [String] :player_session_id
      #   Unique identifier for a player session.
      # @option params [String] :player_session_status_filter
      #   Player session status to filter results on. Possible player session
      #   states include the following: * **RESERVED** – The player session
      #   request has been received, but the
      #     player has not yet connected to the server process and/or been
      #     validated.
      #   * **ACTIVE** – The player has been validated by the server process and
      #     is currently connected.
      #   * **COMPLETED** – The player connection has been dropped.
      #   * **TIMEDOUT** – A player session request was received, but the player
      #     did not connect and/or was not validated within the time-out limit
      #     (60 seconds).
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages. If a player
      #   session ID is specified, this parameter is ignored.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value. If a
      #   player session ID is specified, this parameter is ignored.
      # @return [Types::DescribePlayerSessionsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribePlayerSessionsOutput#player_sessions #PlayerSessions} => Array&lt;Types::PlayerSession&gt;
      #   * {Types::DescribePlayerSessionsOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_player_sessions({
      #     game_session_id: "GameSessionId",
      #     player_id: "NonZeroAndMaxString",
      #     player_session_id: "PlayerSessionId",
      #     player_session_status_filter: "NonZeroAndMaxString",
      #     limit: 1,
      #     next_token: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.player_sessions #=> Array
      #   resp.player_sessions[0].player_session_id #=> String
      #   resp.player_sessions[0].player_id #=> String
      #   resp.player_sessions[0].game_session_id #=> String
      #   resp.player_sessions[0].fleet_id #=> String
      #   resp.player_sessions[0].creation_time #=> Time
      #   resp.player_sessions[0].termination_time #=> Time
      #   resp.player_sessions[0].status #=> String, one of "RESERVED", "ACTIVE", "COMPLETED", "TIMEDOUT"
      #   resp.player_sessions[0].ip_address #=> String
      #   resp.player_sessions[0].port #=> Integer
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_player_sessions(params = {}, options = {})
        req = build_request(:describe_player_sessions, params)
        req.send_request(options)
      end

      # Retrieves the current runtime configuration for the specified fleet.
      # The runtime configuration tells GameLift how to launch server
      # processes on instances in the fleet.
      # @option params [required, String] :fleet_id
      #   Unique identifier of the fleet to get the runtime configuration for.
      # @return [Types::DescribeRuntimeConfigurationOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeRuntimeConfigurationOutput#runtime_configuration #RuntimeConfiguration} => Types::RuntimeConfiguration
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_runtime_configuration({
      #     fleet_id: "FleetId", # required
      #   })
      #
      # @example Response structure
      #   resp.runtime_configuration.server_processes #=> Array
      #   resp.runtime_configuration.server_processes[0].launch_path #=> String
      #   resp.runtime_configuration.server_processes[0].parameters #=> String
      #   resp.runtime_configuration.server_processes[0].concurrent_executions #=> Integer
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_runtime_configuration(params = {}, options = {})
        req = build_request(:describe_runtime_configuration, params)
        req.send_request(options)
      end

      # Retrieves all scaling policies applied to a fleet.
      #
      # To get a fleet\'s scaling policies, specify the fleet ID. You can
      # filter this request by policy status, such as to retrieve only active
      # scaling policies. Use the pagination parameters to retrieve results as
      # a set of sequential pages. If successful, set of ScalingPolicy objects
      # is returned for the fleet.
      # @option params [required, String] :fleet_id
      #   Unique identifier for a fleet. Specify the fleet to retrieve scaling
      #   policies for.
      # @option params [String] :status_filter
      #   Game session status to filter results on. A scaling policy is only in
      #   force when in an Active state. * **ACTIVE** – The scaling policy is
      #   currently in force.
      #   * **UPDATEREQUESTED** – A request to update the scaling policy has
      #     been received.
      #   * **UPDATING** – A change is being made to the scaling policy.
      #   * **DELETEREQUESTED** – A request to delete the scaling policy has
      #     been received.
      #   * **DELETING** – The scaling policy is being deleted.
      #   * **DELETED** – The scaling policy has been deleted.
      #   * **ERROR** – An error occurred in creating the policy. It should be
      #     removed and recreated.
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value.
      # @return [Types::DescribeScalingPoliciesOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeScalingPoliciesOutput#scaling_policies #ScalingPolicies} => Array&lt;Types::ScalingPolicy&gt;
      #   * {Types::DescribeScalingPoliciesOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_scaling_policies({
      #     fleet_id: "FleetId", # required
      #     status_filter: "ACTIVE", # accepts ACTIVE, UPDATE_REQUESTED, UPDATING, DELETE_REQUESTED, DELETING, DELETED, ERROR
      #     limit: 1,
      #     next_token: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.scaling_policies #=> Array
      #   resp.scaling_policies[0].fleet_id #=> String
      #   resp.scaling_policies[0].name #=> String
      #   resp.scaling_policies[0].status #=> String, one of "ACTIVE", "UPDATE_REQUESTED", "UPDATING", "DELETE_REQUESTED", "DELETING", "DELETED", "ERROR"
      #   resp.scaling_policies[0].scaling_adjustment #=> Integer
      #   resp.scaling_policies[0].scaling_adjustment_type #=> String, one of "ChangeInCapacity", "ExactCapacity", "PercentChangeInCapacity"
      #   resp.scaling_policies[0].comparison_operator #=> String, one of "GreaterThanOrEqualToThreshold", "GreaterThanThreshold", "LessThanThreshold", "LessThanOrEqualToThreshold"
      #   resp.scaling_policies[0].threshold #=> Float
      #   resp.scaling_policies[0].evaluation_periods #=> Integer
      #   resp.scaling_policies[0].metric_name #=> String, one of "ActivatingGameSessions", "ActiveGameSessions", "ActiveInstances", "AvailablePlayerSessions", "CurrentPlayerSessions", "IdleInstances"
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_scaling_policies(params = {}, options = {})
        req = build_request(:describe_scaling_policies, params)
        req.send_request(options)
      end

      # Retrieves the location of stored game session logs for a specified
      # game session. When a game session is terminated, Amazon GameLift
      # automatically stores the logs in Amazon S3. Use this URL to download
      # the logs.
      #
      # <note markdown="1"> See the [AWS Service Limits][1] page for maximum log file sizes. Log
      # files that exceed this limit are not saved.
      #
      #  </note>
      #
      #
      #
      # [1]: http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html#limits_gamelift
      # @option params [required, String] :game_session_id
      #   Unique identifier for a game session. Specify the game session you
      #   want to get logs for.
      # @return [Types::GetGameSessionLogUrlOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::GetGameSessionLogUrlOutput#pre_signed_url #PreSignedUrl} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.get_game_session_log_url({
      #     game_session_id: "GameSessionId", # required
      #   })
      #
      # @example Response structure
      #   resp.pre_signed_url #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def get_game_session_log_url(params = {}, options = {})
        req = build_request(:get_game_session_log_url, params)
        req.send_request(options)
      end

      # Retrieves a collection of alias records for this AWS account. You can
      # filter the result set by alias name and/or routing strategy type. Use
      # the pagination parameters to retrieve results in sequential pages.
      #
      # <note markdown="1"> Aliases are not listed in any particular order.
      #
      #  </note>
      # @option params [String] :routing_strategy_type
      #   Type of routing to filter results on. Use this parameter to retrieve
      #   only aliases of a certain type. To retrieve all aliases, leave this
      #   parameter empty. Possible routing types include the following: *
      #   **SIMPLE** – The alias resolves to one specific fleet. Use this type
      #     when routing to active fleets.
      #   * **TERMINAL** – The alias does not resolve to a fleet but instead can
      #     be used to display a message to the user. A terminal alias throws a
      #     TerminalRoutingStrategyException with the RoutingStrategy message
      #     embedded.
      # @option params [String] :name
      #   Descriptive label associated with an alias. Alias names do not need to
      #   be unique.
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value.
      # @return [Types::ListAliasesOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ListAliasesOutput#aliases #Aliases} => Array&lt;Types::Alias&gt;
      #   * {Types::ListAliasesOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.list_aliases({
      #     routing_strategy_type: "SIMPLE", # accepts SIMPLE, TERMINAL
      #     name: "NonEmptyString",
      #     limit: 1,
      #     next_token: "NonEmptyString",
      #   })
      #
      # @example Response structure
      #   resp.aliases #=> Array
      #   resp.aliases[0].alias_id #=> String
      #   resp.aliases[0].name #=> String
      #   resp.aliases[0].description #=> String
      #   resp.aliases[0].routing_strategy.type #=> String, one of "SIMPLE", "TERMINAL"
      #   resp.aliases[0].routing_strategy.fleet_id #=> String
      #   resp.aliases[0].routing_strategy.message #=> String
      #   resp.aliases[0].creation_time #=> Time
      #   resp.aliases[0].last_updated_time #=> Time
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def list_aliases(params = {}, options = {})
        req = build_request(:list_aliases, params)
        req.send_request(options)
      end

      # Retrieves build records for all builds associated with the AWS account
      # in use. You can limit results to builds in a specific state using the
      # `Status` parameter. Use the pagination parameters to retrieve results
      # in a set of sequential pages.
      #
      # <note markdown="1"> Build records are not listed in any particular order.
      #
      #  </note>
      # @option params [String] :status
      #   Build state to filter results by. To retrieve all builds, leave this
      #   parameter empty. Possible build states include the following: *
      #   **INITIALIZED** – A new build has been defined, but no files have
      #     been uploaded. You cannot create fleets for builds that are in this
      #     state. When a build is successfully created, the build state is set
      #     to this value.
      #   * **READY** – The game build has been successfully uploaded. You can
      #     now create new fleets for this build.
      #   * **FAILED** – The game build upload failed. You cannot create new
      #     fleets for this build.
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value.
      # @return [Types::ListBuildsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ListBuildsOutput#builds #Builds} => Array&lt;Types::Build&gt;
      #   * {Types::ListBuildsOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.list_builds({
      #     status: "INITIALIZED", # accepts INITIALIZED, READY, FAILED
      #     limit: 1,
      #     next_token: "NonEmptyString",
      #   })
      #
      # @example Response structure
      #   resp.builds #=> Array
      #   resp.builds[0].build_id #=> String
      #   resp.builds[0].name #=> String
      #   resp.builds[0].version #=> String
      #   resp.builds[0].status #=> String, one of "INITIALIZED", "READY", "FAILED"
      #   resp.builds[0].size_on_disk #=> Integer
      #   resp.builds[0].creation_time #=> Time
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def list_builds(params = {}, options = {})
        req = build_request(:list_builds, params)
        req.send_request(options)
      end

      # Retrieves a collection of fleet records for this AWS account. You can
      # filter the result set by build ID. Use the pagination parameters to
      # retrieve results in sequential pages.
      #
      # <note markdown="1"> Fleet records are not listed in any particular order.
      #
      #  </note>
      # @option params [String] :build_id
      #   Unique identifier of the build to return fleets for. Use this
      #   parameter to return only fleets using the specified build. To retrieve
      #   all fleets, leave this parameter empty.
      # @option params [Integer] :limit
      #   Maximum number of results to return. Use this parameter with
      #   `NextToken` to get results as a set of sequential pages.
      # @option params [String] :next_token
      #   Token indicating the start of the next sequential page of results. Use
      #   the token that is returned with a previous call to this action. To
      #   specify the start of the result set, do not specify a value.
      # @return [Types::ListFleetsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ListFleetsOutput#fleet_ids #FleetIds} => Array&lt;String&gt;
      #   * {Types::ListFleetsOutput#next_token #NextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.list_fleets({
      #     build_id: "BuildId",
      #     limit: 1,
      #     next_token: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.fleet_ids #=> Array
      #   resp.fleet_ids[0] #=> String
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def list_fleets(params = {}, options = {})
        req = build_request(:list_fleets, params)
        req.send_request(options)
      end

      # Creates or updates a scaling policy for a fleet. An active scaling
      # policy prompts Amazon GameLift to track a certain metric for a fleet
      # and automatically change the fleet\'s capacity in specific
      # circumstances. Each scaling policy contains one rule statement. Fleets
      # can have multiple scaling policies in force simultaneously.
      #
      # A scaling policy rule statement has the following structure:
      #
      # If `[MetricName]` is `[ComparisonOperator]` `[Threshold]` for
      # `[EvaluationPeriods]` minutes, then `[ScalingAdjustmentType]` to/by
      # `[ScalingAdjustment]`.
      #
      # For example, this policy: \"If the number of idle instances exceeds 20
      # for more than 15 minutes, then reduce the fleet capacity by 10
      # instances\" could be implemented as the following rule statement:
      #
      # If \[IdleInstances\] is \[GreaterThanOrEqualToThreshold\] \[20\] for
      # \[15\] minutes, then \[ChangeInCapacity\] by \[-10\].
      #
      # To create or update a scaling policy, specify a unique combination of
      # name and fleet ID, and set the rule values. All parameters for this
      # action are required. If successful, the policy name is returned.
      # Scaling policies cannot be suspended or made inactive. To stop
      # enforcing a scaling policy, call DeleteScalingPolicy.
      # @option params [required, String] :name
      #   Descriptive label associated with a scaling policy. Policy names do
      #   not need to be unique. A fleet can have only one scaling policy with
      #   the same name.
      # @option params [required, String] :fleet_id
      #   Unique identity for the fleet to scale with this policy.
      # @option params [required, Integer] :scaling_adjustment
      #   Amount of adjustment to make, based on the scaling adjustment type.
      # @option params [required, String] :scaling_adjustment_type
      #   Type of adjustment to make to a fleet\'s instance count (see
      #   FleetCapacity): * **ChangeInCapacity** – add (or subtract) the scaling
      #   adjustment
      #     value from the current instance count. Positive values scale up
      #     while negative values scale down.
      #   * **ExactCapacity** – set the instance count to the scaling adjustment
      #     value.
      #   * **PercentChangeInCapacity** – increase or reduce the current
      #     instance count by the scaling adjustment, read as a percentage.
      #     Positive values scale up while negative values scale down; for
      #     example, a value of \"-10\" scales the fleet down by 10%.
      # @option params [required, Float] :threshold
      #   Metric value used to trigger a scaling event.
      # @option params [required, String] :comparison_operator
      #   Comparison operator to use when measuring the metric against the
      #   threshold value.
      # @option params [required, Integer] :evaluation_periods
      #   Length of time (in minutes) the metric must be at or beyond the
      #   threshold before a scaling event is triggered.
      # @option params [required, String] :metric_name
      #   Name of the Amazon GameLift-defined metric that is used to trigger an
      #   adjustment. * **ActivatingGameSessions** – number of game sessions in
      #   the process
      #     of being created (game session status = `ACTIVATING`).
      #   * **ActiveGameSessions** – number of game sessions currently running
      #     (game session status = `ACTIVE`).
      #   * **CurrentPlayerSessions** – number of active or reserved player
      #     sessions (player session status = `ACTIVE` or `RESERVED`).
      #   * **AvailablePlayerSessions** – number of player session slots
      #     currently available in active game sessions across the fleet,
      #     calculated by subtracting a game session\'s current player session
      #     count from its maximum player session count. This number includes
      #     game sessions that are not currently accepting players (game session
      #     `PlayerSessionCreationPolicy` = `DENY_ALL`).
      #   * **ActiveInstances** – number of instances currently running a game
      #     session.
      #   * **IdleInstances** – number of instances not currently running a game
      #     session.
      # @return [Types::PutScalingPolicyOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::PutScalingPolicyOutput#name #Name} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.put_scaling_policy({
      #     name: "NonZeroAndMaxString", # required
      #     fleet_id: "FleetId", # required
      #     scaling_adjustment: 1, # required
      #     scaling_adjustment_type: "ChangeInCapacity", # required, accepts ChangeInCapacity, ExactCapacity, PercentChangeInCapacity
      #     threshold: 1.0, # required
      #     comparison_operator: "GreaterThanOrEqualToThreshold", # required, accepts GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold
      #     evaluation_periods: 1, # required
      #     metric_name: "ActivatingGameSessions", # required, accepts ActivatingGameSessions, ActiveGameSessions, ActiveInstances, AvailablePlayerSessions, CurrentPlayerSessions, IdleInstances
      #   })
      #
      # @example Response structure
      #   resp.name #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def put_scaling_policy(params = {}, options = {})
        req = build_request(:put_scaling_policy, params)
        req.send_request(options)
      end

      # Retrieves a fresh set of upload credentials and the assigned Amazon S3
      # storage location for a specific build. Valid credentials are required
      # to upload your game build files to Amazon S3.
      #
      # <important markdown="1"> Call this action only if you need credentials for a build created with
      # `CreateBuild`. This is a rare situation; in most cases, builds are
      # created using the CLI command `upload-build`, which creates a build
      # record and also uploads build files.
      #
      #  </important>
      #
      # Upload credentials are returned when you create the build, but they
      # have a limited lifespan. You can get fresh credentials and use them to
      # re-upload game files until the state of that build changes to `READY`.
      # Once this happens, you must create a brand new build.
      # @option params [required, String] :build_id
      #   Unique identifier for the build you want to get credentials for.
      # @return [Types::RequestUploadCredentialsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::RequestUploadCredentialsOutput#upload_credentials #UploadCredentials} => Types::AwsCredentials
      #   * {Types::RequestUploadCredentialsOutput#storage_location #StorageLocation} => Types::S3Location
      #
      # @example Request syntax with placeholder values
      #   resp = client.request_upload_credentials({
      #     build_id: "BuildId", # required
      #   })
      #
      # @example Response structure
      #   resp.upload_credentials.access_key_id #=> String
      #   resp.upload_credentials.secret_access_key #=> String
      #   resp.upload_credentials.session_token #=> String
      #   resp.storage_location.bucket #=> String
      #   resp.storage_location.key #=> String
      #   resp.storage_location.role_arn #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def request_upload_credentials(params = {}, options = {})
        req = build_request(:request_upload_credentials, params)
        req.send_request(options)
      end

      # Retrieves the fleet ID that a specified alias is currently pointing
      # to.
      # @option params [required, String] :alias_id
      #   Unique identifier for the alias you want to resolve.
      # @return [Types::ResolveAliasOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ResolveAliasOutput#fleet_id #FleetId} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.resolve_alias({
      #     alias_id: "AliasId", # required
      #   })
      #
      # @example Response structure
      #   resp.fleet_id #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def resolve_alias(params = {}, options = {})
        req = build_request(:resolve_alias, params)
        req.send_request(options)
      end

      # Updates properties for an alias. To update properties, specify the
      # alias ID to be updated and provide the information to be changed. To
      # reassign an alias to another fleet, provide an updated routing
      # strategy. If successful, the updated alias record is returned.
      # @option params [required, String] :alias_id
      #   Unique identifier for a fleet alias. Specify the alias you want to
      #   update.
      # @option params [String] :name
      #   Descriptive label associated with an alias. Alias names do not need to
      #   be unique.
      # @option params [String] :description
      #   Human-readable description of an alias.
      # @option params [Types::RoutingStrategy] :routing_strategy
      #   Object specifying the fleet and routing type to use for the alias.
      # @return [Types::UpdateAliasOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::UpdateAliasOutput#alias #Alias} => Types::Alias
      #
      # @example Request syntax with placeholder values
      #   resp = client.update_alias({
      #     alias_id: "AliasId", # required
      #     name: "NonZeroAndMaxString",
      #     description: "NonZeroAndMaxString",
      #     routing_strategy: {
      #       type: "SIMPLE", # accepts SIMPLE, TERMINAL
      #       fleet_id: "FleetId",
      #       message: "FreeText",
      #     },
      #   })
      #
      # @example Response structure
      #   resp.alias.alias_id #=> String
      #   resp.alias.name #=> String
      #   resp.alias.description #=> String
      #   resp.alias.routing_strategy.type #=> String, one of "SIMPLE", "TERMINAL"
      #   resp.alias.routing_strategy.fleet_id #=> String
      #   resp.alias.routing_strategy.message #=> String
      #   resp.alias.creation_time #=> Time
      #   resp.alias.last_updated_time #=> Time
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def update_alias(params = {}, options = {})
        req = build_request(:update_alias, params)
        req.send_request(options)
      end

      # Updates metadata in a build record, including the build name and
      # version. To update the metadata, specify the build ID to update and
      # provide the new values. If successful, a build object containing the
      # updated metadata is returned.
      # @option params [required, String] :build_id
      #   Unique identifier of the build you want to update.
      # @option params [String] :name
      #   Descriptive label associated with a build. Build names do not need to
      #   be unique.
      # @option params [String] :version
      #   Version associated with this build. Version strings do not need to be
      #   unique to a build.
      # @return [Types::UpdateBuildOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::UpdateBuildOutput#build #Build} => Types::Build
      #
      # @example Request syntax with placeholder values
      #   resp = client.update_build({
      #     build_id: "BuildId", # required
      #     name: "NonZeroAndMaxString",
      #     version: "NonZeroAndMaxString",
      #   })
      #
      # @example Response structure
      #   resp.build.build_id #=> String
      #   resp.build.name #=> String
      #   resp.build.version #=> String
      #   resp.build.status #=> String, one of "INITIALIZED", "READY", "FAILED"
      #   resp.build.size_on_disk #=> Integer
      #   resp.build.creation_time #=> Time
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def update_build(params = {}, options = {})
        req = build_request(:update_build, params)
        req.send_request(options)
      end

      # Updates fleet properties, including name and description, for a fleet.
      # To update metadata, specify the fleet ID and the property values you
      # want to change. If successful, the fleet ID for the updated fleet is
      # returned.
      # @option params [required, String] :fleet_id
      #   Unique identifier for the fleet you want to update attribute metadata
      #   for.
      # @option params [String] :name
      #   Descriptive label associated with a fleet. Fleet names do not need to
      #   be unique.
      # @option params [String] :description
      #   Human-readable description of a fleet.
      # @option params [String] :new_game_session_protection_policy
      #   Game session protection policy to apply to all new instances created
      #   in this fleet. Instances that already exist are not affected. You can
      #   set protection for individual instances using UpdateGameSession. *
      #   **NoProtection** – The game session can be terminated during a
      #     scale-down event.
      #   * **FullProtection** – If the game session is in an `ACTIVE` status,
      #     it cannot be terminated during a scale-down event.
      # @return [Types::UpdateFleetAttributesOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::UpdateFleetAttributesOutput#fleet_id #FleetId} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.update_fleet_attributes({
      #     fleet_id: "FleetId", # required
      #     name: "NonZeroAndMaxString",
      #     description: "NonZeroAndMaxString",
      #     new_game_session_protection_policy: "NoProtection", # accepts NoProtection, FullProtection
      #   })
      #
      # @example Response structure
      #   resp.fleet_id #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def update_fleet_attributes(params = {}, options = {})
        req = build_request(:update_fleet_attributes, params)
        req.send_request(options)
      end

      # Updates capacity settings for a fleet. Use this action to specify the
      # number of EC2 instances (hosts) that you want this fleet to contain.
      # Before calling this action, you may want to call
      # DescribeEC2InstanceLimits to get the maximum capacity based on the
      # fleet\'s EC2 instance type.
      #
      # If you\'re using autoscaling (see PutScalingPolicy), you may want to
      # specify a minimum and/or maximum capacity. If you don\'t provide
      # these, autoscaling can set capacity anywhere between zero and the
      # [service limits][1].
      #
      # To update fleet capacity, specify the fleet ID and the number of
      # instances you want the fleet to host. If successful, Amazon GameLift
      # starts or terminates instances so that the fleet\'s active instance
      # count matches the desired instance count. You can view a fleet\'s
      # current capacity information by calling DescribeFleetCapacity. If the
      # desired instance count is higher than the instance type\'s limit, the
      # \"Limit Exceeded\" exception occurs.
      #
      #
      #
      # [1]: http://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html#limits_gamelift
      # @option params [required, String] :fleet_id
      #   Unique identifier for the fleet you want to update capacity for.
      # @option params [Integer] :desired_instances
      #   Number of EC2 instances you want this fleet to host.
      # @option params [Integer] :min_size
      #   Minimum value allowed for the fleet\'s instance count. Default if not
      #   set is 0.
      # @option params [Integer] :max_size
      #   Maximum value allowed for the fleet\'s instance count. Default if not
      #   set is 1.
      # @return [Types::UpdateFleetCapacityOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::UpdateFleetCapacityOutput#fleet_id #FleetId} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.update_fleet_capacity({
      #     fleet_id: "FleetId", # required
      #     desired_instances: 1,
      #     min_size: 1,
      #     max_size: 1,
      #   })
      #
      # @example Response structure
      #   resp.fleet_id #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def update_fleet_capacity(params = {}, options = {})
        req = build_request(:update_fleet_capacity, params)
        req.send_request(options)
      end

      # Updates port settings for a fleet. To update settings, specify the
      # fleet ID to be updated and list the permissions you want to update.
      # List the permissions you want to add in
      # `InboundPermissionAuthorizations`, and permissions you want to remove
      # in `InboundPermissionRevocations`. Permissions to be removed must
      # match existing fleet permissions. If successful, the fleet ID for the
      # updated fleet is returned.
      # @option params [required, String] :fleet_id
      #   Unique identifier for the fleet you want to update port settings for.
      # @option params [Array<Types::IpPermission>] :inbound_permission_authorizations
      #   Collection of port settings to be added to the fleet record.
      # @option params [Array<Types::IpPermission>] :inbound_permission_revocations
      #   Collection of port settings to be removed from the fleet record.
      # @return [Types::UpdateFleetPortSettingsOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::UpdateFleetPortSettingsOutput#fleet_id #FleetId} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.update_fleet_port_settings({
      #     fleet_id: "FleetId", # required
      #     inbound_permission_authorizations: [
      #       {
      #         from_port: 1, # required
      #         to_port: 1, # required
      #         ip_range: "NonBlankString", # required
      #         protocol: "TCP", # required, accepts TCP, UDP
      #       },
      #     ],
      #     inbound_permission_revocations: [
      #       {
      #         from_port: 1, # required
      #         to_port: 1, # required
      #         ip_range: "NonBlankString", # required
      #         protocol: "TCP", # required, accepts TCP, UDP
      #       },
      #     ],
      #   })
      #
      # @example Response structure
      #   resp.fleet_id #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def update_fleet_port_settings(params = {}, options = {})
        req = build_request(:update_fleet_port_settings, params)
        req.send_request(options)
      end

      # Updates game session properties. This includes the session name,
      # maximum player count, protection policy, which controls whether or not
      # an active game session can be terminated during a scale-down event,
      # and the player session creation policy, which controls whether or not
      # new players can join the session. To update a game session, specify
      # the game session ID and the values you want to change. If successful,
      # an updated GameSession object is returned.
      # @option params [required, String] :game_session_id
      #   Unique identifier for a game session. Specify the game session you
      #   want to update.
      # @option params [Integer] :maximum_player_session_count
      #   Maximum number of players that can be simultaneously connected to the
      #   game session.
      # @option params [String] :name
      #   Descriptive label associated with a game session. Session names do not
      #   need to be unique.
      # @option params [String] :player_session_creation_policy
      #   Policy determining whether or not the game session accepts new
      #   players.
      # @option params [String] :protection_policy
      #   Game session protection policy to apply to this game session only. *
      #   **NoProtection** – The game session can be terminated during a
      #     scale-down event.
      #   * **FullProtection** – If the game session is in an `ACTIVE` status,
      #     it cannot be terminated during a scale-down event.
      # @return [Types::UpdateGameSessionOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::UpdateGameSessionOutput#game_session #GameSession} => Types::GameSession
      #
      # @example Request syntax with placeholder values
      #   resp = client.update_game_session({
      #     game_session_id: "GameSessionId", # required
      #     maximum_player_session_count: 1,
      #     name: "NonZeroAndMaxString",
      #     player_session_creation_policy: "ACCEPT_ALL", # accepts ACCEPT_ALL, DENY_ALL
      #     protection_policy: "NoProtection", # accepts NoProtection, FullProtection
      #   })
      #
      # @example Response structure
      #   resp.game_session.game_session_id #=> String
      #   resp.game_session.name #=> String
      #   resp.game_session.fleet_id #=> String
      #   resp.game_session.creation_time #=> Time
      #   resp.game_session.termination_time #=> Time
      #   resp.game_session.current_player_session_count #=> Integer
      #   resp.game_session.maximum_player_session_count #=> Integer
      #   resp.game_session.status #=> String, one of "ACTIVE", "ACTIVATING", "TERMINATED", "TERMINATING"
      #   resp.game_session.game_properties #=> Array
      #   resp.game_session.game_properties[0].key #=> String
      #   resp.game_session.game_properties[0].value #=> String
      #   resp.game_session.ip_address #=> String
      #   resp.game_session.port #=> Integer
      #   resp.game_session.player_session_creation_policy #=> String, one of "ACCEPT_ALL", "DENY_ALL"
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def update_game_session(params = {}, options = {})
        req = build_request(:update_game_session, params)
        req.send_request(options)
      end

      # Updates the current runtime configuration for the specified fleet,
      # which tells GameLift how to launch server processes on instances in
      # the fleet. You can update a fleet\'s runtime configuration at any time
      # after the fleet is created; it does not need to be in an `ACTIVE`
      # state.
      #
      # To update runtime configuration, specify the fleet ID and provide a
      # `RuntimeConfiguration` object with the updated collection of server
      # process configurations.
      #
      # Each instance in a GameLift fleet checks regularly for an updated
      # runtime configuration and changes how it launches server processes to
      # comply with the latest version. Existing server processes are not
      # affected by the update; they continue to run until they end, while
      # GameLift simply adds new server processes to fit the current runtime
      # configuration. As a result, the runtime configuration changes are
      # applied gradually as existing processes shut down and new processes
      # are launched in GameLift\'s normal process recycling activity.
      # @option params [required, String] :fleet_id
      #   Unique identifier of the fleet to update runtime configuration for.
      # @option params [required, Types::RuntimeConfiguration] :runtime_configuration
      #   Instructions for launching server processes on each instance in the
      #   fleet. The runtime configuration for a fleet has a collection of
      #   server process configurations, one for each type of server process to
      #   run on an instance. A server process configuration specifies the
      #   location of the server executable, launch parameters, and the number
      #   of concurrent processes with that configuration to maintain on each
      #   instance.
      # @return [Types::UpdateRuntimeConfigurationOutput] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::UpdateRuntimeConfigurationOutput#runtime_configuration #RuntimeConfiguration} => Types::RuntimeConfiguration
      #
      # @example Request syntax with placeholder values
      #   resp = client.update_runtime_configuration({
      #     fleet_id: "FleetId", # required
      #     runtime_configuration: { # required
      #       server_processes: [
      #         {
      #           launch_path: "NonZeroAndMaxString", # required
      #           parameters: "NonZeroAndMaxString",
      #           concurrent_executions: 1, # required
      #         },
      #       ],
      #     },
      #   })
      #
      # @example Response structure
      #   resp.runtime_configuration.server_processes #=> Array
      #   resp.runtime_configuration.server_processes[0].launch_path #=> String
      #   resp.runtime_configuration.server_processes[0].parameters #=> String
      #   resp.runtime_configuration.server_processes[0].concurrent_executions #=> Integer
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def update_runtime_configuration(params = {}, options = {})
        req = build_request(:update_runtime_configuration, params)
        req.send_request(options)
      end

      # @!endgroup

      # @param [Symbol] waiter_name
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      # @option options [Integer] :max_attempts
      # @option options [Integer] :delay
      # @option options [Proc] :before_attempt
      # @option options [Proc] :before_wait
      def wait_until(waiter_name, params = {}, options = {})
        w = waiter(waiter_name, options)
        yield(w.waiter) if block_given? # deprecated
        w.wait(params)
      end

      def waiter_names
        waiters.keys
      end

      private

      # @param [Symbol] waiter_name
      # @param [Hash] options ({})
      def waiter(waiter_name, options = {})
        waiter_class = waiters[waiter_name]
        if waiter_class
          waiter_class.new(options.merge(client: self))
        else
          raise Aws::Waiters::Errors::NoSuchWaiterError.new(waiter_name, waiters.keys)
        end
      end

      def waiters
        {}
      end

      # @api private
      class << self

        attr_reader :identifier

        def errors_module
          Errors
        end

      end
    end
  end
end
