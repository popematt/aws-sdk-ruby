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
  module ECS
    class Client < Seahorse::Client::Base

      include Aws::ClientStubs
      include Aws::ClientWaiters

      @identifier = :ecs

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

      # Creates a new Amazon ECS cluster. By default, your account receives a
      # `default` cluster when you launch your first container instance.
      # However, you can create your own cluster with a unique name with the
      # `CreateCluster` action.
      # @option params [String] :cluster_name
      #   The name of your cluster. If you do not specify a name for your
      #   cluster, you create a cluster named `default`. Up to 255 letters
      #   (uppercase and lowercase), numbers, hyphens, and underscores are
      #   allowed.
      # @return [Types::CreateClusterResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::CreateClusterResponse#cluster #cluster} => Types::Cluster
      #
      # @example Request syntax with placeholder values
      #   resp = client.create_cluster({
      #     cluster_name: "String",
      #   })
      #
      # @example Response structure
      #   resp.cluster.cluster_arn #=> String
      #   resp.cluster.cluster_name #=> String
      #   resp.cluster.status #=> String
      #   resp.cluster.registered_container_instances_count #=> Integer
      #   resp.cluster.running_tasks_count #=> Integer
      #   resp.cluster.pending_tasks_count #=> Integer
      #   resp.cluster.active_services_count #=> Integer
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def create_cluster(params = {}, options = {})
        req = build_request(:create_cluster, params)
        req.send_request(options)
      end

      # Runs and maintains a desired number of tasks from a specified task
      # definition. If the number of tasks running in a service drops below
      # `desiredCount`, Amazon ECS spawns another instantiation of the task in
      # the specified cluster. To update an existing service, see
      # UpdateService.
      #
      # In addition to maintaining the desired count of tasks in your service,
      # you can optionally run your service behind a load balancer. The load
      # balancer distributes traffic across the tasks that are associated with
      # the service.
      #
      # You can optionally specify a deployment configuration for your
      # service. During a deployment (which is triggered by changing the task
      # definition of a service with an UpdateService operation), the service
      # scheduler uses the `minimumHealthyPercent` and `maximumPercent`
      # parameters to determine the deployment strategy.
      #
      # If the `minimumHealthyPercent` is below 100%, the scheduler can ignore
      # the `desiredCount` temporarily during a deployment. For example, if
      # your service has a `desiredCount` of four tasks, a
      # `minimumHealthyPercent` of 50% allows the scheduler to stop two
      # existing tasks before starting two new tasks. Tasks for services that
      # *do not* use a load balancer are considered healthy if they are in the
      # `RUNNING` state; tasks for services that *do* use a load balancer are
      # considered healthy if they are in the `RUNNING` state and the
      # container instance it is hosted on is reported as healthy by the load
      # balancer. The default value for `minimumHealthyPercent` is 50% in the
      # console and 100% for the AWS CLI, the AWS SDKs, and the APIs.
      #
      # The `maximumPercent` parameter represents an upper limit on the number
      # of running tasks during a deployment, which enables you to define the
      # deployment batch size. For example, if your service has a
      # `desiredCount` of four tasks, a `maximumPercent` value of 200% starts
      # four new tasks before stopping the four older tasks (provided that the
      # cluster resources required to do this are available). The default
      # value for `maximumPercent` is 200%.
      #
      # When the service scheduler launches new tasks, it attempts to balance
      # them across the Availability Zones in your cluster with the following
      # logic:
      #
      # * Determine which of the container instances in your cluster can
      #   support your service\'s task definition (for example, they have the
      #   required CPU, memory, ports, and container instance attributes).
      #
      # * Sort the valid container instances by the fewest number of running
      #   tasks for this service in the same Availability Zone as the
      #   instance. For example, if zone A has one running service task and
      #   zones B and C each have zero, valid container instances in either
      #   zone B or C are considered optimal for placement.
      #
      # * Place the new service task on a valid container instance in an
      #   optimal Availability Zone (based on the previous steps), favoring
      #   container instances with the fewest number of running tasks for this
      #   service.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster on
      #   which to run your service. If you do not specify a cluster, the
      #   default cluster is assumed.
      # @option params [required, String] :service_name
      #   The name of your service. Up to 255 letters (uppercase and lowercase),
      #   numbers, hyphens, and underscores are allowed. Service names must be
      #   unique within a cluster, but you can have similarly named services in
      #   multiple clusters within a region or across multiple regions.
      # @option params [required, String] :task_definition
      #   The `family` and `revision` (`family:revision`) or full Amazon
      #   Resource Name (ARN) of the task definition to run in your service. If
      #   a `revision` is not specified, the latest `ACTIVE` revision is used.
      # @option params [Array<Types::LoadBalancer>] :load_balancers
      #   A list of load balancer objects, containing the load balancer name,
      #   the container name (as it appears in a container definition), and the
      #   container port to access from the load balancer.
      # @option params [required, Integer] :desired_count
      #   The number of instantiations of the specified task definition to place
      #   and keep running on your cluster.
      # @option params [String] :client_token
      #   Unique, case-sensitive identifier you provide to ensure the
      #   idempotency of the request. Up to 32 ASCII characters are allowed.
      # @option params [String] :role
      #   The name or full Amazon Resource Name (ARN) of the IAM role that
      #   allows Amazon ECS to make calls to your load balancer on your behalf.
      #   This parameter is required if you are using a load balancer with your
      #   service. If you specify the `role` parameter, you must also specify a
      #   load balancer object with the `loadBalancers` parameter.
      #
      #   If your specified role has a path other than `/`, then you must either
      #   specify the full role ARN (this is recommended) or prefix the role
      #   name with the path. For example, if a role with the name `bar` has a
      #   path of `/foo/` then you would specify `/foo/bar` as the role name.
      #   For more information, see [Friendly Names and Paths][1] in the *IAM
      #   User Guide*.
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-friendly-names
      # @option params [Types::DeploymentConfiguration] :deployment_configuration
      #   Optional deployment parameters that control how many tasks run during
      #   the deployment and the ordering of stopping and starting tasks.
      # @return [Types::CreateServiceResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::CreateServiceResponse#service #service} => Types::Service
      #
      # @example Request syntax with placeholder values
      #   resp = client.create_service({
      #     cluster: "String",
      #     service_name: "String", # required
      #     task_definition: "String", # required
      #     load_balancers: [
      #       {
      #         load_balancer_name: "String",
      #         container_name: "String",
      #         container_port: 1,
      #       },
      #     ],
      #     desired_count: 1, # required
      #     client_token: "String",
      #     role: "String",
      #     deployment_configuration: {
      #       maximum_percent: 1,
      #       minimum_healthy_percent: 1,
      #     },
      #   })
      #
      # @example Response structure
      #   resp.service.service_arn #=> String
      #   resp.service.service_name #=> String
      #   resp.service.cluster_arn #=> String
      #   resp.service.load_balancers #=> Array
      #   resp.service.load_balancers[0].load_balancer_name #=> String
      #   resp.service.load_balancers[0].container_name #=> String
      #   resp.service.load_balancers[0].container_port #=> Integer
      #   resp.service.status #=> String
      #   resp.service.desired_count #=> Integer
      #   resp.service.running_count #=> Integer
      #   resp.service.pending_count #=> Integer
      #   resp.service.task_definition #=> String
      #   resp.service.deployment_configuration.maximum_percent #=> Integer
      #   resp.service.deployment_configuration.minimum_healthy_percent #=> Integer
      #   resp.service.deployments #=> Array
      #   resp.service.deployments[0].id #=> String
      #   resp.service.deployments[0].status #=> String
      #   resp.service.deployments[0].task_definition #=> String
      #   resp.service.deployments[0].desired_count #=> Integer
      #   resp.service.deployments[0].pending_count #=> Integer
      #   resp.service.deployments[0].running_count #=> Integer
      #   resp.service.deployments[0].created_at #=> Time
      #   resp.service.deployments[0].updated_at #=> Time
      #   resp.service.role_arn #=> String
      #   resp.service.events #=> Array
      #   resp.service.events[0].id #=> String
      #   resp.service.events[0].created_at #=> Time
      #   resp.service.events[0].message #=> String
      #   resp.service.created_at #=> Time
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def create_service(params = {}, options = {})
        req = build_request(:create_service, params)
        req.send_request(options)
      end

      # Deletes the specified cluster. You must deregister all container
      # instances from this cluster before you may delete it. You can list the
      # container instances in a cluster with ListContainerInstances and
      # deregister them with DeregisterContainerInstance.
      # @option params [required, String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster to
      #   delete.
      # @return [Types::DeleteClusterResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DeleteClusterResponse#cluster #cluster} => Types::Cluster
      #
      # @example Request syntax with placeholder values
      #   resp = client.delete_cluster({
      #     cluster: "String", # required
      #   })
      #
      # @example Response structure
      #   resp.cluster.cluster_arn #=> String
      #   resp.cluster.cluster_name #=> String
      #   resp.cluster.status #=> String
      #   resp.cluster.registered_container_instances_count #=> Integer
      #   resp.cluster.running_tasks_count #=> Integer
      #   resp.cluster.pending_tasks_count #=> Integer
      #   resp.cluster.active_services_count #=> Integer
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def delete_cluster(params = {}, options = {})
        req = build_request(:delete_cluster, params)
        req.send_request(options)
      end

      # Deletes a specified service within a cluster. You can delete a service
      # if you have no running tasks in it and the desired task count is zero.
      # If the service is actively maintaining tasks, you cannot delete it,
      # and you must update the service to a desired task count of zero. For
      # more information, see UpdateService.
      #
      # <note markdown="1"> When you delete a service, if there are still running tasks that
      # require cleanup, the service status moves from `ACTIVE` to `DRAINING`,
      # and the service is no longer visible in the console or in ListServices
      # API operations. After the tasks have stopped, then the service status
      # moves from `DRAINING` to `INACTIVE`. Services in the `DRAINING` or
      # `INACTIVE` status can still be viewed with DescribeServices API
      # operations; however, in the future, `INACTIVE` services may be cleaned
      # up and purged from Amazon ECS record keeping, and DescribeServices API
      # operations on those services will return a `ServiceNotFoundException`
      # error.
      #
      #  </note>
      # @option params [String] :cluster
      #   The name of the cluster that hosts the service to delete. If you do
      #   not specify a cluster, the default cluster is assumed.
      # @option params [required, String] :service
      #   The name of the service to delete.
      # @return [Types::DeleteServiceResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DeleteServiceResponse#service #service} => Types::Service
      #
      # @example Request syntax with placeholder values
      #   resp = client.delete_service({
      #     cluster: "String",
      #     service: "String", # required
      #   })
      #
      # @example Response structure
      #   resp.service.service_arn #=> String
      #   resp.service.service_name #=> String
      #   resp.service.cluster_arn #=> String
      #   resp.service.load_balancers #=> Array
      #   resp.service.load_balancers[0].load_balancer_name #=> String
      #   resp.service.load_balancers[0].container_name #=> String
      #   resp.service.load_balancers[0].container_port #=> Integer
      #   resp.service.status #=> String
      #   resp.service.desired_count #=> Integer
      #   resp.service.running_count #=> Integer
      #   resp.service.pending_count #=> Integer
      #   resp.service.task_definition #=> String
      #   resp.service.deployment_configuration.maximum_percent #=> Integer
      #   resp.service.deployment_configuration.minimum_healthy_percent #=> Integer
      #   resp.service.deployments #=> Array
      #   resp.service.deployments[0].id #=> String
      #   resp.service.deployments[0].status #=> String
      #   resp.service.deployments[0].task_definition #=> String
      #   resp.service.deployments[0].desired_count #=> Integer
      #   resp.service.deployments[0].pending_count #=> Integer
      #   resp.service.deployments[0].running_count #=> Integer
      #   resp.service.deployments[0].created_at #=> Time
      #   resp.service.deployments[0].updated_at #=> Time
      #   resp.service.role_arn #=> String
      #   resp.service.events #=> Array
      #   resp.service.events[0].id #=> String
      #   resp.service.events[0].created_at #=> Time
      #   resp.service.events[0].message #=> String
      #   resp.service.created_at #=> Time
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def delete_service(params = {}, options = {})
        req = build_request(:delete_service, params)
        req.send_request(options)
      end

      # Deregisters an Amazon ECS container instance from the specified
      # cluster. This instance is no longer available to run tasks.
      #
      # If you intend to use the container instance for some other purpose
      # after deregistration, you should stop all of the tasks running on the
      # container instance before deregistration to avoid any orphaned tasks
      # from consuming resources.
      #
      # Deregistering a container instance removes the instance from a
      # cluster, but it does not terminate the EC2 instance; if you are
      # finished using the instance, be sure to terminate it in the Amazon EC2
      # console to stop billing.
      #
      # <note markdown="1"> If you terminate a running container instance with a connected Amazon
      # ECS container agent, the agent automatically deregisters the instance
      # from your cluster (stopped container instances or instances with
      # disconnected agents are not automatically deregistered when
      # terminated).
      #
      #  </note>
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   hosts the container instance to deregister. If you do not specify a
      #   cluster, the default cluster is assumed.
      # @option params [required, String] :container_instance
      #   The container instance ID or full Amazon Resource Name (ARN) of the
      #   container instance to deregister. The ARN contains the `arn:aws:ecs`
      #   namespace, followed by the region of the container instance, the AWS
      #   account ID of the container instance owner, the `container-instance`
      #   namespace, and then the container instance ID. For example,
      #   `arn:aws:ecs:region:aws_account_id:container-instance/container_instance_ID
      #   `.
      # @option params [Boolean] :force
      #   Forces the deregistration of the container instance. If you have tasks
      #   running on the container instance when you deregister it with the
      #   `force` option, these tasks remain running and they continue to pass
      #   Elastic Load Balancing load balancer health checks until you terminate
      #   the instance or the tasks stop through some other means, but they are
      #   orphaned (no longer monitored or accounted for by Amazon ECS). If an
      #   orphaned task on your container instance is part of an Amazon ECS
      #   service, then the service scheduler starts another copy of that task,
      #   on a different container instance if possible.
      # @return [Types::DeregisterContainerInstanceResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DeregisterContainerInstanceResponse#container_instance #containerInstance} => Types::ContainerInstance
      #
      # @example Request syntax with placeholder values
      #   resp = client.deregister_container_instance({
      #     cluster: "String",
      #     container_instance: "String", # required
      #     force: false,
      #   })
      #
      # @example Response structure
      #   resp.container_instance.container_instance_arn #=> String
      #   resp.container_instance.ec2_instance_id #=> String
      #   resp.container_instance.version_info.agent_version #=> String
      #   resp.container_instance.version_info.agent_hash #=> String
      #   resp.container_instance.version_info.docker_version #=> String
      #   resp.container_instance.remaining_resources #=> Array
      #   resp.container_instance.remaining_resources[0].name #=> String
      #   resp.container_instance.remaining_resources[0].type #=> String
      #   resp.container_instance.remaining_resources[0].double_value #=> Float
      #   resp.container_instance.remaining_resources[0].long_value #=> Integer
      #   resp.container_instance.remaining_resources[0].integer_value #=> Integer
      #   resp.container_instance.remaining_resources[0].string_set_value #=> Array
      #   resp.container_instance.remaining_resources[0].string_set_value[0] #=> String
      #   resp.container_instance.registered_resources #=> Array
      #   resp.container_instance.registered_resources[0].name #=> String
      #   resp.container_instance.registered_resources[0].type #=> String
      #   resp.container_instance.registered_resources[0].double_value #=> Float
      #   resp.container_instance.registered_resources[0].long_value #=> Integer
      #   resp.container_instance.registered_resources[0].integer_value #=> Integer
      #   resp.container_instance.registered_resources[0].string_set_value #=> Array
      #   resp.container_instance.registered_resources[0].string_set_value[0] #=> String
      #   resp.container_instance.status #=> String
      #   resp.container_instance.agent_connected #=> Boolean
      #   resp.container_instance.running_tasks_count #=> Integer
      #   resp.container_instance.pending_tasks_count #=> Integer
      #   resp.container_instance.agent_update_status #=> String, one of "PENDING", "STAGING", "STAGED", "UPDATING", "UPDATED", "FAILED"
      #   resp.container_instance.attributes #=> Array
      #   resp.container_instance.attributes[0].name #=> String
      #   resp.container_instance.attributes[0].value #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def deregister_container_instance(params = {}, options = {})
        req = build_request(:deregister_container_instance, params)
        req.send_request(options)
      end

      # Deregisters the specified task definition by family and revision. Upon
      # deregistration, the task definition is marked as `INACTIVE`. Existing
      # tasks and services that reference an `INACTIVE` task definition
      # continue to run without disruption. Existing services that reference
      # an `INACTIVE` task definition can still scale up or down by modifying
      # the service\'s desired count.
      #
      # You cannot use an `INACTIVE` task definition to run new tasks or
      # create new services, and you cannot update an existing service to
      # reference an `INACTIVE` task definition (although there may be up to a
      # 10 minute window following deregistration where these restrictions
      # have not yet taken effect).
      # @option params [required, String] :task_definition
      #   The `family` and `revision` (`family:revision`) or full Amazon
      #   Resource Name (ARN) of the task definition to deregister. You must
      #   specify a `revision`.
      # @return [Types::DeregisterTaskDefinitionResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DeregisterTaskDefinitionResponse#task_definition #taskDefinition} => Types::TaskDefinition
      #
      # @example Request syntax with placeholder values
      #   resp = client.deregister_task_definition({
      #     task_definition: "String", # required
      #   })
      #
      # @example Response structure
      #   resp.task_definition.task_definition_arn #=> String
      #   resp.task_definition.container_definitions #=> Array
      #   resp.task_definition.container_definitions[0].name #=> String
      #   resp.task_definition.container_definitions[0].image #=> String
      #   resp.task_definition.container_definitions[0].cpu #=> Integer
      #   resp.task_definition.container_definitions[0].memory #=> Integer
      #   resp.task_definition.container_definitions[0].links #=> Array
      #   resp.task_definition.container_definitions[0].links[0] #=> String
      #   resp.task_definition.container_definitions[0].port_mappings #=> Array
      #   resp.task_definition.container_definitions[0].port_mappings[0].container_port #=> Integer
      #   resp.task_definition.container_definitions[0].port_mappings[0].host_port #=> Integer
      #   resp.task_definition.container_definitions[0].port_mappings[0].protocol #=> String, one of "tcp", "udp"
      #   resp.task_definition.container_definitions[0].essential #=> Boolean
      #   resp.task_definition.container_definitions[0].entry_point #=> Array
      #   resp.task_definition.container_definitions[0].entry_point[0] #=> String
      #   resp.task_definition.container_definitions[0].command #=> Array
      #   resp.task_definition.container_definitions[0].command[0] #=> String
      #   resp.task_definition.container_definitions[0].environment #=> Array
      #   resp.task_definition.container_definitions[0].environment[0].name #=> String
      #   resp.task_definition.container_definitions[0].environment[0].value #=> String
      #   resp.task_definition.container_definitions[0].mount_points #=> Array
      #   resp.task_definition.container_definitions[0].mount_points[0].source_volume #=> String
      #   resp.task_definition.container_definitions[0].mount_points[0].container_path #=> String
      #   resp.task_definition.container_definitions[0].mount_points[0].read_only #=> Boolean
      #   resp.task_definition.container_definitions[0].volumes_from #=> Array
      #   resp.task_definition.container_definitions[0].volumes_from[0].source_container #=> String
      #   resp.task_definition.container_definitions[0].volumes_from[0].read_only #=> Boolean
      #   resp.task_definition.container_definitions[0].hostname #=> String
      #   resp.task_definition.container_definitions[0].user #=> String
      #   resp.task_definition.container_definitions[0].working_directory #=> String
      #   resp.task_definition.container_definitions[0].disable_networking #=> Boolean
      #   resp.task_definition.container_definitions[0].privileged #=> Boolean
      #   resp.task_definition.container_definitions[0].readonly_root_filesystem #=> Boolean
      #   resp.task_definition.container_definitions[0].dns_servers #=> Array
      #   resp.task_definition.container_definitions[0].dns_servers[0] #=> String
      #   resp.task_definition.container_definitions[0].dns_search_domains #=> Array
      #   resp.task_definition.container_definitions[0].dns_search_domains[0] #=> String
      #   resp.task_definition.container_definitions[0].extra_hosts #=> Array
      #   resp.task_definition.container_definitions[0].extra_hosts[0].hostname #=> String
      #   resp.task_definition.container_definitions[0].extra_hosts[0].ip_address #=> String
      #   resp.task_definition.container_definitions[0].docker_security_options #=> Array
      #   resp.task_definition.container_definitions[0].docker_security_options[0] #=> String
      #   resp.task_definition.container_definitions[0].docker_labels #=> Hash
      #   resp.task_definition.container_definitions[0].docker_labels["String"] #=> String
      #   resp.task_definition.container_definitions[0].ulimits #=> Array
      #   resp.task_definition.container_definitions[0].ulimits[0].name #=> String, one of "core", "cpu", "data", "fsize", "locks", "memlock", "msgqueue", "nice", "nofile", "nproc", "rss", "rtprio", "rttime", "sigpending", "stack"
      #   resp.task_definition.container_definitions[0].ulimits[0].soft_limit #=> Integer
      #   resp.task_definition.container_definitions[0].ulimits[0].hard_limit #=> Integer
      #   resp.task_definition.container_definitions[0].log_configuration.log_driver #=> String, one of "json-file", "syslog", "journald", "gelf", "fluentd", "awslogs"
      #   resp.task_definition.container_definitions[0].log_configuration.options #=> Hash
      #   resp.task_definition.container_definitions[0].log_configuration.options["String"] #=> String
      #   resp.task_definition.family #=> String
      #   resp.task_definition.task_role_arn #=> String
      #   resp.task_definition.revision #=> Integer
      #   resp.task_definition.volumes #=> Array
      #   resp.task_definition.volumes[0].name #=> String
      #   resp.task_definition.volumes[0].host.source_path #=> String
      #   resp.task_definition.status #=> String, one of "ACTIVE", "INACTIVE"
      #   resp.task_definition.requires_attributes #=> Array
      #   resp.task_definition.requires_attributes[0].name #=> String
      #   resp.task_definition.requires_attributes[0].value #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def deregister_task_definition(params = {}, options = {})
        req = build_request(:deregister_task_definition, params)
        req.send_request(options)
      end

      # Describes one or more of your clusters.
      # @option params [Array<String>] :clusters
      #   A space-separated list of up to 100 cluster names or full cluster
      #   Amazon Resource Name (ARN) entries. If you do not specify a cluster,
      #   the default cluster is assumed.
      # @return [Types::DescribeClustersResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeClustersResponse#clusters #clusters} => Array&lt;Types::Cluster&gt;
      #   * {Types::DescribeClustersResponse#failures #failures} => Array&lt;Types::Failure&gt;
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_clusters({
      #     clusters: ["String"],
      #   })
      #
      # @example Response structure
      #   resp.clusters #=> Array
      #   resp.clusters[0].cluster_arn #=> String
      #   resp.clusters[0].cluster_name #=> String
      #   resp.clusters[0].status #=> String
      #   resp.clusters[0].registered_container_instances_count #=> Integer
      #   resp.clusters[0].running_tasks_count #=> Integer
      #   resp.clusters[0].pending_tasks_count #=> Integer
      #   resp.clusters[0].active_services_count #=> Integer
      #   resp.failures #=> Array
      #   resp.failures[0].arn #=> String
      #   resp.failures[0].reason #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_clusters(params = {}, options = {})
        req = build_request(:describe_clusters, params)
        req.send_request(options)
      end

      # Describes Amazon EC2 Container Service container instances. Returns
      # metadata about registered and remaining resources on each container
      # instance requested.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   hosts the container instances to describe. If you do not specify a
      #   cluster, the default cluster is assumed.
      # @option params [required, Array<String>] :container_instances
      #   A space-separated list of container instance IDs or full Amazon
      #   Resource Name (ARN) entries.
      # @return [Types::DescribeContainerInstancesResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeContainerInstancesResponse#container_instances #containerInstances} => Array&lt;Types::ContainerInstance&gt;
      #   * {Types::DescribeContainerInstancesResponse#failures #failures} => Array&lt;Types::Failure&gt;
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_container_instances({
      #     cluster: "String",
      #     container_instances: ["String"], # required
      #   })
      #
      # @example Response structure
      #   resp.container_instances #=> Array
      #   resp.container_instances[0].container_instance_arn #=> String
      #   resp.container_instances[0].ec2_instance_id #=> String
      #   resp.container_instances[0].version_info.agent_version #=> String
      #   resp.container_instances[0].version_info.agent_hash #=> String
      #   resp.container_instances[0].version_info.docker_version #=> String
      #   resp.container_instances[0].remaining_resources #=> Array
      #   resp.container_instances[0].remaining_resources[0].name #=> String
      #   resp.container_instances[0].remaining_resources[0].type #=> String
      #   resp.container_instances[0].remaining_resources[0].double_value #=> Float
      #   resp.container_instances[0].remaining_resources[0].long_value #=> Integer
      #   resp.container_instances[0].remaining_resources[0].integer_value #=> Integer
      #   resp.container_instances[0].remaining_resources[0].string_set_value #=> Array
      #   resp.container_instances[0].remaining_resources[0].string_set_value[0] #=> String
      #   resp.container_instances[0].registered_resources #=> Array
      #   resp.container_instances[0].registered_resources[0].name #=> String
      #   resp.container_instances[0].registered_resources[0].type #=> String
      #   resp.container_instances[0].registered_resources[0].double_value #=> Float
      #   resp.container_instances[0].registered_resources[0].long_value #=> Integer
      #   resp.container_instances[0].registered_resources[0].integer_value #=> Integer
      #   resp.container_instances[0].registered_resources[0].string_set_value #=> Array
      #   resp.container_instances[0].registered_resources[0].string_set_value[0] #=> String
      #   resp.container_instances[0].status #=> String
      #   resp.container_instances[0].agent_connected #=> Boolean
      #   resp.container_instances[0].running_tasks_count #=> Integer
      #   resp.container_instances[0].pending_tasks_count #=> Integer
      #   resp.container_instances[0].agent_update_status #=> String, one of "PENDING", "STAGING", "STAGED", "UPDATING", "UPDATED", "FAILED"
      #   resp.container_instances[0].attributes #=> Array
      #   resp.container_instances[0].attributes[0].name #=> String
      #   resp.container_instances[0].attributes[0].value #=> String
      #   resp.failures #=> Array
      #   resp.failures[0].arn #=> String
      #   resp.failures[0].reason #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_container_instances(params = {}, options = {})
        req = build_request(:describe_container_instances, params)
        req.send_request(options)
      end

      # Describes the specified services running in your cluster.
      # @option params [String] :cluster
      #   The name of the cluster that hosts the service to describe. If you do
      #   not specify a cluster, the default cluster is assumed.
      # @option params [required, Array<String>] :services
      #   A list of services to describe.
      # @return [Types::DescribeServicesResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeServicesResponse#services #services} => Array&lt;Types::Service&gt;
      #   * {Types::DescribeServicesResponse#failures #failures} => Array&lt;Types::Failure&gt;
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_services({
      #     cluster: "String",
      #     services: ["String"], # required
      #   })
      #
      # @example Response structure
      #   resp.services #=> Array
      #   resp.services[0].service_arn #=> String
      #   resp.services[0].service_name #=> String
      #   resp.services[0].cluster_arn #=> String
      #   resp.services[0].load_balancers #=> Array
      #   resp.services[0].load_balancers[0].load_balancer_name #=> String
      #   resp.services[0].load_balancers[0].container_name #=> String
      #   resp.services[0].load_balancers[0].container_port #=> Integer
      #   resp.services[0].status #=> String
      #   resp.services[0].desired_count #=> Integer
      #   resp.services[0].running_count #=> Integer
      #   resp.services[0].pending_count #=> Integer
      #   resp.services[0].task_definition #=> String
      #   resp.services[0].deployment_configuration.maximum_percent #=> Integer
      #   resp.services[0].deployment_configuration.minimum_healthy_percent #=> Integer
      #   resp.services[0].deployments #=> Array
      #   resp.services[0].deployments[0].id #=> String
      #   resp.services[0].deployments[0].status #=> String
      #   resp.services[0].deployments[0].task_definition #=> String
      #   resp.services[0].deployments[0].desired_count #=> Integer
      #   resp.services[0].deployments[0].pending_count #=> Integer
      #   resp.services[0].deployments[0].running_count #=> Integer
      #   resp.services[0].deployments[0].created_at #=> Time
      #   resp.services[0].deployments[0].updated_at #=> Time
      #   resp.services[0].role_arn #=> String
      #   resp.services[0].events #=> Array
      #   resp.services[0].events[0].id #=> String
      #   resp.services[0].events[0].created_at #=> Time
      #   resp.services[0].events[0].message #=> String
      #   resp.services[0].created_at #=> Time
      #   resp.failures #=> Array
      #   resp.failures[0].arn #=> String
      #   resp.failures[0].reason #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_services(params = {}, options = {})
        req = build_request(:describe_services, params)
        req.send_request(options)
      end

      # Describes a task definition. You can specify a `family` and `revision`
      # to find information about a specific task definition, or you can
      # simply specify the family to find the latest `ACTIVE` revision in that
      # family.
      #
      # <note markdown="1"> You can only describe `INACTIVE` task definitions while an active task
      # or service references them.
      #
      #  </note>
      # @option params [required, String] :task_definition
      #   The `family` for the latest `ACTIVE` revision, `family` and `revision`
      #   (`family:revision`) for a specific revision in the family, or full
      #   Amazon Resource Name (ARN) of the task definition to describe.
      # @return [Types::DescribeTaskDefinitionResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeTaskDefinitionResponse#task_definition #taskDefinition} => Types::TaskDefinition
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_task_definition({
      #     task_definition: "String", # required
      #   })
      #
      # @example Response structure
      #   resp.task_definition.task_definition_arn #=> String
      #   resp.task_definition.container_definitions #=> Array
      #   resp.task_definition.container_definitions[0].name #=> String
      #   resp.task_definition.container_definitions[0].image #=> String
      #   resp.task_definition.container_definitions[0].cpu #=> Integer
      #   resp.task_definition.container_definitions[0].memory #=> Integer
      #   resp.task_definition.container_definitions[0].links #=> Array
      #   resp.task_definition.container_definitions[0].links[0] #=> String
      #   resp.task_definition.container_definitions[0].port_mappings #=> Array
      #   resp.task_definition.container_definitions[0].port_mappings[0].container_port #=> Integer
      #   resp.task_definition.container_definitions[0].port_mappings[0].host_port #=> Integer
      #   resp.task_definition.container_definitions[0].port_mappings[0].protocol #=> String, one of "tcp", "udp"
      #   resp.task_definition.container_definitions[0].essential #=> Boolean
      #   resp.task_definition.container_definitions[0].entry_point #=> Array
      #   resp.task_definition.container_definitions[0].entry_point[0] #=> String
      #   resp.task_definition.container_definitions[0].command #=> Array
      #   resp.task_definition.container_definitions[0].command[0] #=> String
      #   resp.task_definition.container_definitions[0].environment #=> Array
      #   resp.task_definition.container_definitions[0].environment[0].name #=> String
      #   resp.task_definition.container_definitions[0].environment[0].value #=> String
      #   resp.task_definition.container_definitions[0].mount_points #=> Array
      #   resp.task_definition.container_definitions[0].mount_points[0].source_volume #=> String
      #   resp.task_definition.container_definitions[0].mount_points[0].container_path #=> String
      #   resp.task_definition.container_definitions[0].mount_points[0].read_only #=> Boolean
      #   resp.task_definition.container_definitions[0].volumes_from #=> Array
      #   resp.task_definition.container_definitions[0].volumes_from[0].source_container #=> String
      #   resp.task_definition.container_definitions[0].volumes_from[0].read_only #=> Boolean
      #   resp.task_definition.container_definitions[0].hostname #=> String
      #   resp.task_definition.container_definitions[0].user #=> String
      #   resp.task_definition.container_definitions[0].working_directory #=> String
      #   resp.task_definition.container_definitions[0].disable_networking #=> Boolean
      #   resp.task_definition.container_definitions[0].privileged #=> Boolean
      #   resp.task_definition.container_definitions[0].readonly_root_filesystem #=> Boolean
      #   resp.task_definition.container_definitions[0].dns_servers #=> Array
      #   resp.task_definition.container_definitions[0].dns_servers[0] #=> String
      #   resp.task_definition.container_definitions[0].dns_search_domains #=> Array
      #   resp.task_definition.container_definitions[0].dns_search_domains[0] #=> String
      #   resp.task_definition.container_definitions[0].extra_hosts #=> Array
      #   resp.task_definition.container_definitions[0].extra_hosts[0].hostname #=> String
      #   resp.task_definition.container_definitions[0].extra_hosts[0].ip_address #=> String
      #   resp.task_definition.container_definitions[0].docker_security_options #=> Array
      #   resp.task_definition.container_definitions[0].docker_security_options[0] #=> String
      #   resp.task_definition.container_definitions[0].docker_labels #=> Hash
      #   resp.task_definition.container_definitions[0].docker_labels["String"] #=> String
      #   resp.task_definition.container_definitions[0].ulimits #=> Array
      #   resp.task_definition.container_definitions[0].ulimits[0].name #=> String, one of "core", "cpu", "data", "fsize", "locks", "memlock", "msgqueue", "nice", "nofile", "nproc", "rss", "rtprio", "rttime", "sigpending", "stack"
      #   resp.task_definition.container_definitions[0].ulimits[0].soft_limit #=> Integer
      #   resp.task_definition.container_definitions[0].ulimits[0].hard_limit #=> Integer
      #   resp.task_definition.container_definitions[0].log_configuration.log_driver #=> String, one of "json-file", "syslog", "journald", "gelf", "fluentd", "awslogs"
      #   resp.task_definition.container_definitions[0].log_configuration.options #=> Hash
      #   resp.task_definition.container_definitions[0].log_configuration.options["String"] #=> String
      #   resp.task_definition.family #=> String
      #   resp.task_definition.task_role_arn #=> String
      #   resp.task_definition.revision #=> Integer
      #   resp.task_definition.volumes #=> Array
      #   resp.task_definition.volumes[0].name #=> String
      #   resp.task_definition.volumes[0].host.source_path #=> String
      #   resp.task_definition.status #=> String, one of "ACTIVE", "INACTIVE"
      #   resp.task_definition.requires_attributes #=> Array
      #   resp.task_definition.requires_attributes[0].name #=> String
      #   resp.task_definition.requires_attributes[0].value #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_task_definition(params = {}, options = {})
        req = build_request(:describe_task_definition, params)
        req.send_request(options)
      end

      # Describes a specified task or tasks.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   hosts the task to describe. If you do not specify a cluster, the
      #   default cluster is assumed.
      # @option params [required, Array<String>] :tasks
      #   A space-separated list of task IDs or full Amazon Resource Name (ARN)
      #   entries.
      # @return [Types::DescribeTasksResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DescribeTasksResponse#tasks #tasks} => Array&lt;Types::Task&gt;
      #   * {Types::DescribeTasksResponse#failures #failures} => Array&lt;Types::Failure&gt;
      #
      # @example Request syntax with placeholder values
      #   resp = client.describe_tasks({
      #     cluster: "String",
      #     tasks: ["String"], # required
      #   })
      #
      # @example Response structure
      #   resp.tasks #=> Array
      #   resp.tasks[0].task_arn #=> String
      #   resp.tasks[0].cluster_arn #=> String
      #   resp.tasks[0].task_definition_arn #=> String
      #   resp.tasks[0].container_instance_arn #=> String
      #   resp.tasks[0].overrides.container_overrides #=> Array
      #   resp.tasks[0].overrides.container_overrides[0].name #=> String
      #   resp.tasks[0].overrides.container_overrides[0].command #=> Array
      #   resp.tasks[0].overrides.container_overrides[0].command[0] #=> String
      #   resp.tasks[0].overrides.container_overrides[0].environment #=> Array
      #   resp.tasks[0].overrides.container_overrides[0].environment[0].name #=> String
      #   resp.tasks[0].overrides.container_overrides[0].environment[0].value #=> String
      #   resp.tasks[0].overrides.task_role_arn #=> String
      #   resp.tasks[0].last_status #=> String
      #   resp.tasks[0].desired_status #=> String
      #   resp.tasks[0].containers #=> Array
      #   resp.tasks[0].containers[0].container_arn #=> String
      #   resp.tasks[0].containers[0].task_arn #=> String
      #   resp.tasks[0].containers[0].name #=> String
      #   resp.tasks[0].containers[0].last_status #=> String
      #   resp.tasks[0].containers[0].exit_code #=> Integer
      #   resp.tasks[0].containers[0].reason #=> String
      #   resp.tasks[0].containers[0].network_bindings #=> Array
      #   resp.tasks[0].containers[0].network_bindings[0].bind_ip #=> String
      #   resp.tasks[0].containers[0].network_bindings[0].container_port #=> Integer
      #   resp.tasks[0].containers[0].network_bindings[0].host_port #=> Integer
      #   resp.tasks[0].containers[0].network_bindings[0].protocol #=> String, one of "tcp", "udp"
      #   resp.tasks[0].started_by #=> String
      #   resp.tasks[0].stopped_reason #=> String
      #   resp.tasks[0].created_at #=> Time
      #   resp.tasks[0].started_at #=> Time
      #   resp.tasks[0].stopped_at #=> Time
      #   resp.failures #=> Array
      #   resp.failures[0].arn #=> String
      #   resp.failures[0].reason #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def describe_tasks(params = {}, options = {})
        req = build_request(:describe_tasks, params)
        req.send_request(options)
      end

      # <note markdown="1"> This action is only used by the Amazon EC2 Container Service agent,
      # and it is not intended for use outside of the agent.
      #
      #  </note>
      #
      # Returns an endpoint for the Amazon EC2 Container Service agent to poll
      # for updates.
      # @option params [String] :container_instance
      #   The container instance ID or full Amazon Resource Name (ARN) of the
      #   container instance. The ARN contains the `arn:aws:ecs` namespace,
      #   followed by the region of the container instance, the AWS account ID
      #   of the container instance owner, the `container-instance` namespace,
      #   and then the container instance ID. For example,
      #   `arn:aws:ecs:region:aws_account_id:container-instance/container_instance_ID
      #   `.
      # @option params [String] :cluster
      #   The cluster that the container instance belongs to.
      # @return [Types::DiscoverPollEndpointResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::DiscoverPollEndpointResponse#endpoint #endpoint} => String
      #   * {Types::DiscoverPollEndpointResponse#telemetry_endpoint #telemetryEndpoint} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.discover_poll_endpoint({
      #     container_instance: "String",
      #     cluster: "String",
      #   })
      #
      # @example Response structure
      #   resp.endpoint #=> String
      #   resp.telemetry_endpoint #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def discover_poll_endpoint(params = {}, options = {})
        req = build_request(:discover_poll_endpoint, params)
        req.send_request(options)
      end

      # Returns a list of existing clusters.
      # @option params [String] :next_token
      #   The `nextToken` value returned from a previous paginated
      #   `ListClusters` request where `maxResults` was used and the results
      #   exceeded the value of that parameter. Pagination continues from the
      #   end of the previous results that returned the `nextToken` value. This
      #   value is `null` when there are no more results to return.
      #
      #   <note markdown="1"> This token should be treated as an opaque identifier that is only used
      #   to retrieve the next items in a list and not for other programmatic
      #   purposes.
      #
      #    </note>
      # @option params [Integer] :max_results
      #   The maximum number of cluster results returned by `ListClusters` in
      #   paginated output. When this parameter is used, `ListClusters` only
      #   returns `maxResults` results in a single page along with a `nextToken`
      #   response element. The remaining results of the initial request can be
      #   seen by sending another `ListClusters` request with the returned
      #   `nextToken` value. This value can be between 1 and 100. If this
      #   parameter is not used, then `ListClusters` returns up to 100 results
      #   and a `nextToken` value if applicable.
      # @return [Types::ListClustersResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ListClustersResponse#cluster_arns #clusterArns} => Array&lt;String&gt;
      #   * {Types::ListClustersResponse#next_token #nextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.list_clusters({
      #     next_token: "String",
      #     max_results: 1,
      #   })
      #
      # @example Response structure
      #   resp.cluster_arns #=> Array
      #   resp.cluster_arns[0] #=> String
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def list_clusters(params = {}, options = {})
        req = build_request(:list_clusters, params)
        req.send_request(options)
      end

      # Returns a list of container instances in a specified cluster.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   hosts the container instances to list. If you do not specify a
      #   cluster, the default cluster is assumed..
      # @option params [String] :next_token
      #   The `nextToken` value returned from a previous paginated
      #   `ListContainerInstances` request where `maxResults` was used and the
      #   results exceeded the value of that parameter. Pagination continues
      #   from the end of the previous results that returned the `nextToken`
      #   value. This value is `null` when there are no more results to return.
      #
      #   <note markdown="1"> This token should be treated as an opaque identifier that is only used
      #   to retrieve the next items in a list and not for other programmatic
      #   purposes.
      #
      #    </note>
      # @option params [Integer] :max_results
      #   The maximum number of container instance results returned by
      #   `ListContainerInstances` in paginated output. When this parameter is
      #   used, `ListContainerInstances` only returns `maxResults` results in a
      #   single page along with a `nextToken` response element. The remaining
      #   results of the initial request can be seen by sending another
      #   `ListContainerInstances` request with the returned `nextToken` value.
      #   This value can be between 1 and 100. If this parameter is not used,
      #   then `ListContainerInstances` returns up to 100 results and a
      #   `nextToken` value if applicable.
      # @return [Types::ListContainerInstancesResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ListContainerInstancesResponse#container_instance_arns #containerInstanceArns} => Array&lt;String&gt;
      #   * {Types::ListContainerInstancesResponse#next_token #nextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.list_container_instances({
      #     cluster: "String",
      #     next_token: "String",
      #     max_results: 1,
      #   })
      #
      # @example Response structure
      #   resp.container_instance_arns #=> Array
      #   resp.container_instance_arns[0] #=> String
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def list_container_instances(params = {}, options = {})
        req = build_request(:list_container_instances, params)
        req.send_request(options)
      end

      # Lists the services that are running in a specified cluster.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   hosts the services to list. If you do not specify a cluster, the
      #   default cluster is assumed..
      # @option params [String] :next_token
      #   The `nextToken` value returned from a previous paginated
      #   `ListServices` request where `maxResults` was used and the results
      #   exceeded the value of that parameter. Pagination continues from the
      #   end of the previous results that returned the `nextToken` value. This
      #   value is `null` when there are no more results to return.
      #
      #   <note markdown="1"> This token should be treated as an opaque identifier that is only used
      #   to retrieve the next items in a list and not for other programmatic
      #   purposes.
      #
      #    </note>
      # @option params [Integer] :max_results
      #   The maximum number of container instance results returned by
      #   `ListServices` in paginated output. When this parameter is used,
      #   `ListServices` only returns `maxResults` results in a single page
      #   along with a `nextToken` response element. The remaining results of
      #   the initial request can be seen by sending another `ListServices`
      #   request with the returned `nextToken` value. This value can be between
      #   1 and 10. If this parameter is not used, then `ListServices` returns
      #   up to 10 results and a `nextToken` value if applicable.
      # @return [Types::ListServicesResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ListServicesResponse#service_arns #serviceArns} => Array&lt;String&gt;
      #   * {Types::ListServicesResponse#next_token #nextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.list_services({
      #     cluster: "String",
      #     next_token: "String",
      #     max_results: 1,
      #   })
      #
      # @example Response structure
      #   resp.service_arns #=> Array
      #   resp.service_arns[0] #=> String
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def list_services(params = {}, options = {})
        req = build_request(:list_services, params)
        req.send_request(options)
      end

      # Returns a list of task definition families that are registered to your
      # account (which may include task definition families that no longer
      # have any `ACTIVE` task definition revisions).
      #
      # You can filter out task definition families that do not contain any
      # `ACTIVE` task definition revisions by setting the `status` parameter
      # to `ACTIVE`. You can also filter the results with the `familyPrefix`
      # parameter.
      # @option params [String] :family_prefix
      #   The `familyPrefix` is a string that is used to filter the results of
      #   `ListTaskDefinitionFamilies`. If you specify a `familyPrefix`, only
      #   task definition family names that begin with the `familyPrefix` string
      #   are returned.
      # @option params [String] :status
      #   The task definition family status with which to filter the
      #   `ListTaskDefinitionFamilies` results. By default, both `ACTIVE` and
      #   `INACTIVE` task definition families are listed. If this parameter is
      #   set to `ACTIVE`, only task definition families that have an `ACTIVE`
      #   task definition revision are returned. If this parameter is set to
      #   `INACTIVE`, only task definition families that do not have any
      #   `ACTIVE` task definition revisions are returned. If you paginate the
      #   resulting output, be sure to keep the `status` value constant in each
      #   subsequent request.
      # @option params [String] :next_token
      #   The `nextToken` value returned from a previous paginated
      #   `ListTaskDefinitionFamilies` request where `maxResults` was used and
      #   the results exceeded the value of that parameter. Pagination continues
      #   from the end of the previous results that returned the `nextToken`
      #   value. This value is `null` when there are no more results to return.
      #
      #   <note markdown="1"> This token should be treated as an opaque identifier that is only used
      #   to retrieve the next items in a list and not for other programmatic
      #   purposes.
      #
      #    </note>
      # @option params [Integer] :max_results
      #   The maximum number of task definition family results returned by
      #   `ListTaskDefinitionFamilies` in paginated output. When this parameter
      #   is used, `ListTaskDefinitions` only returns `maxResults` results in a
      #   single page along with a `nextToken` response element. The remaining
      #   results of the initial request can be seen by sending another
      #   `ListTaskDefinitionFamilies` request with the returned `nextToken`
      #   value. This value can be between 1 and 100. If this parameter is not
      #   used, then `ListTaskDefinitionFamilies` returns up to 100 results and
      #   a `nextToken` value if applicable.
      # @return [Types::ListTaskDefinitionFamiliesResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ListTaskDefinitionFamiliesResponse#families #families} => Array&lt;String&gt;
      #   * {Types::ListTaskDefinitionFamiliesResponse#next_token #nextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.list_task_definition_families({
      #     family_prefix: "String",
      #     status: "ACTIVE", # accepts ACTIVE, INACTIVE, ALL
      #     next_token: "String",
      #     max_results: 1,
      #   })
      #
      # @example Response structure
      #   resp.families #=> Array
      #   resp.families[0] #=> String
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def list_task_definition_families(params = {}, options = {})
        req = build_request(:list_task_definition_families, params)
        req.send_request(options)
      end

      # Returns a list of task definitions that are registered to your
      # account. You can filter the results by family name with the
      # `familyPrefix` parameter or by status with the `status` parameter.
      # @option params [String] :family_prefix
      #   The full family name with which to filter the `ListTaskDefinitions`
      #   results. Specifying a `familyPrefix` limits the listed task
      #   definitions to task definition revisions that belong to that family.
      # @option params [String] :status
      #   The task definition status with which to filter the
      #   `ListTaskDefinitions` results. By default, only `ACTIVE` task
      #   definitions are listed. By setting this parameter to `INACTIVE`, you
      #   can view task definitions that are `INACTIVE` as long as an active
      #   task or service still references them. If you paginate the resulting
      #   output, be sure to keep the `status` value constant in each subsequent
      #   request.
      # @option params [String] :sort
      #   The order in which to sort the results. Valid values are `ASC` and
      #   `DESC`. By default (`ASC`), task definitions are listed
      #   lexicographically by family name and in ascending numerical order by
      #   revision so that the newest task definitions in a family are listed
      #   last. Setting this parameter to `DESC` reverses the sort order on
      #   family name and revision so that the newest task definitions in a
      #   family are listed first.
      # @option params [String] :next_token
      #   The `nextToken` value returned from a previous paginated
      #   `ListTaskDefinitions` request where `maxResults` was used and the
      #   results exceeded the value of that parameter. Pagination continues
      #   from the end of the previous results that returned the `nextToken`
      #   value. This value is `null` when there are no more results to return.
      #
      #   <note markdown="1"> This token should be treated as an opaque identifier that is only used
      #   to retrieve the next items in a list and not for other programmatic
      #   purposes.
      #
      #    </note>
      # @option params [Integer] :max_results
      #   The maximum number of task definition results returned by
      #   `ListTaskDefinitions` in paginated output. When this parameter is
      #   used, `ListTaskDefinitions` only returns `maxResults` results in a
      #   single page along with a `nextToken` response element. The remaining
      #   results of the initial request can be seen by sending another
      #   `ListTaskDefinitions` request with the returned `nextToken` value.
      #   This value can be between 1 and 100. If this parameter is not used,
      #   then `ListTaskDefinitions` returns up to 100 results and a `nextToken`
      #   value if applicable.
      # @return [Types::ListTaskDefinitionsResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ListTaskDefinitionsResponse#task_definition_arns #taskDefinitionArns} => Array&lt;String&gt;
      #   * {Types::ListTaskDefinitionsResponse#next_token #nextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.list_task_definitions({
      #     family_prefix: "String",
      #     status: "ACTIVE", # accepts ACTIVE, INACTIVE
      #     sort: "ASC", # accepts ASC, DESC
      #     next_token: "String",
      #     max_results: 1,
      #   })
      #
      # @example Response structure
      #   resp.task_definition_arns #=> Array
      #   resp.task_definition_arns[0] #=> String
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def list_task_definitions(params = {}, options = {})
        req = build_request(:list_task_definitions, params)
        req.send_request(options)
      end

      # Returns a list of tasks for a specified cluster. You can filter the
      # results by family name, by a particular container instance, or by the
      # desired status of the task with the `family`, `containerInstance`, and
      # `desiredStatus` parameters.
      #
      # Recently-stopped tasks might appear in the returned results.
      # Currently, stopped tasks appear in the returned results for at least
      # one hour.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   hosts the tasks to list. If you do not specify a cluster, the default
      #   cluster is assumed..
      # @option params [String] :container_instance
      #   The container instance ID or full Amazon Resource Name (ARN) of the
      #   container instance with which to filter the `ListTasks` results.
      #   Specifying a `containerInstance` limits the results to tasks that
      #   belong to that container instance.
      # @option params [String] :family
      #   The name of the family with which to filter the `ListTasks` results.
      #   Specifying a `family` limits the results to tasks that belong to that
      #   family.
      # @option params [String] :next_token
      #   The `nextToken` value returned from a previous paginated `ListTasks`
      #   request where `maxResults` was used and the results exceeded the value
      #   of that parameter. Pagination continues from the end of the previous
      #   results that returned the `nextToken` value. This value is `null` when
      #   there are no more results to return.
      #
      #   <note markdown="1"> This token should be treated as an opaque identifier that is only used
      #   to retrieve the next items in a list and not for other programmatic
      #   purposes.
      #
      #    </note>
      # @option params [Integer] :max_results
      #   The maximum number of task results returned by `ListTasks` in
      #   paginated output. When this parameter is used, `ListTasks` only
      #   returns `maxResults` results in a single page along with a `nextToken`
      #   response element. The remaining results of the initial request can be
      #   seen by sending another `ListTasks` request with the returned
      #   `nextToken` value. This value can be between 1 and 100. If this
      #   parameter is not used, then `ListTasks` returns up to 100 results and
      #   a `nextToken` value if applicable.
      # @option params [String] :started_by
      #   The `startedBy` value with which to filter the task results.
      #   Specifying a `startedBy` value limits the results to tasks that were
      #   started with that value.
      # @option params [String] :service_name
      #   The name of the service with which to filter the `ListTasks` results.
      #   Specifying a `serviceName` limits the results to tasks that belong to
      #   that service.
      # @option params [String] :desired_status
      #   The task status with which to filter the `ListTasks` results.
      #   Specifying a `desiredStatus` of `STOPPED` limits the results to tasks
      #   that are in the `STOPPED` status, which can be useful for debugging
      #   tasks that are not starting properly or have died or finished. The
      #   default status filter is status filter is `RUNNING`, which shows tasks
      #   that ECS has set the desired status to `RUNNING`.
      #
      #   <note markdown="1"> Although you can filter results based on a desired status of
      #   `PENDING`, this will not return any results because ECS never sets the
      #   desired status of a task to that value (only a task\'s `lastStatus`
      #   may have a value of `PENDING`).
      #
      #    </note>
      # @return [Types::ListTasksResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::ListTasksResponse#task_arns #taskArns} => Array&lt;String&gt;
      #   * {Types::ListTasksResponse#next_token #nextToken} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.list_tasks({
      #     cluster: "String",
      #     container_instance: "String",
      #     family: "String",
      #     next_token: "String",
      #     max_results: 1,
      #     started_by: "String",
      #     service_name: "String",
      #     desired_status: "RUNNING", # accepts RUNNING, PENDING, STOPPED
      #   })
      #
      # @example Response structure
      #   resp.task_arns #=> Array
      #   resp.task_arns[0] #=> String
      #   resp.next_token #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def list_tasks(params = {}, options = {})
        req = build_request(:list_tasks, params)
        req.send_request(options)
      end

      # <note markdown="1"> This action is only used by the Amazon EC2 Container Service agent,
      # and it is not intended for use outside of the agent.
      #
      #  </note>
      #
      # Registers an EC2 instance into the specified cluster. This instance
      # becomes available to place containers on.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster with
      #   which to register your container instance. If you do not specify a
      #   cluster, the default cluster is assumed..
      # @option params [String] :instance_identity_document
      #   The instance identity document for the EC2 instance to register. This
      #   document can be found by running the following command from the
      #   instance: `curl
      #   http://169.254.169.254/latest/dynamic/instance-identity/document/`
      # @option params [String] :instance_identity_document_signature
      #   The instance identity document signature for the EC2 instance to
      #   register. This signature can be found by running the following command
      #   from the instance: `curl
      #   http://169.254.169.254/latest/dynamic/instance-identity/signature/`
      # @option params [Array<Types::Resource>] :total_resources
      #   The resources available on the instance.
      # @option params [Types::VersionInfo] :version_info
      #   The version information for the Amazon ECS container agent and Docker
      #   daemon running on the container instance.
      # @option params [String] :container_instance_arn
      #   The Amazon Resource Name (ARN) of the container instance (if it was
      #   previously registered).
      # @option params [Array<Types::Attribute>] :attributes
      #   The container instance attributes that this container instance
      #   supports.
      # @return [Types::RegisterContainerInstanceResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::RegisterContainerInstanceResponse#container_instance #containerInstance} => Types::ContainerInstance
      #
      # @example Request syntax with placeholder values
      #   resp = client.register_container_instance({
      #     cluster: "String",
      #     instance_identity_document: "String",
      #     instance_identity_document_signature: "String",
      #     total_resources: [
      #       {
      #         name: "String",
      #         type: "String",
      #         double_value: 1.0,
      #         long_value: 1,
      #         integer_value: 1,
      #         string_set_value: ["String"],
      #       },
      #     ],
      #     version_info: {
      #       agent_version: "String",
      #       agent_hash: "String",
      #       docker_version: "String",
      #     },
      #     container_instance_arn: "String",
      #     attributes: [
      #       {
      #         name: "String", # required
      #         value: "String",
      #       },
      #     ],
      #   })
      #
      # @example Response structure
      #   resp.container_instance.container_instance_arn #=> String
      #   resp.container_instance.ec2_instance_id #=> String
      #   resp.container_instance.version_info.agent_version #=> String
      #   resp.container_instance.version_info.agent_hash #=> String
      #   resp.container_instance.version_info.docker_version #=> String
      #   resp.container_instance.remaining_resources #=> Array
      #   resp.container_instance.remaining_resources[0].name #=> String
      #   resp.container_instance.remaining_resources[0].type #=> String
      #   resp.container_instance.remaining_resources[0].double_value #=> Float
      #   resp.container_instance.remaining_resources[0].long_value #=> Integer
      #   resp.container_instance.remaining_resources[0].integer_value #=> Integer
      #   resp.container_instance.remaining_resources[0].string_set_value #=> Array
      #   resp.container_instance.remaining_resources[0].string_set_value[0] #=> String
      #   resp.container_instance.registered_resources #=> Array
      #   resp.container_instance.registered_resources[0].name #=> String
      #   resp.container_instance.registered_resources[0].type #=> String
      #   resp.container_instance.registered_resources[0].double_value #=> Float
      #   resp.container_instance.registered_resources[0].long_value #=> Integer
      #   resp.container_instance.registered_resources[0].integer_value #=> Integer
      #   resp.container_instance.registered_resources[0].string_set_value #=> Array
      #   resp.container_instance.registered_resources[0].string_set_value[0] #=> String
      #   resp.container_instance.status #=> String
      #   resp.container_instance.agent_connected #=> Boolean
      #   resp.container_instance.running_tasks_count #=> Integer
      #   resp.container_instance.pending_tasks_count #=> Integer
      #   resp.container_instance.agent_update_status #=> String, one of "PENDING", "STAGING", "STAGED", "UPDATING", "UPDATED", "FAILED"
      #   resp.container_instance.attributes #=> Array
      #   resp.container_instance.attributes[0].name #=> String
      #   resp.container_instance.attributes[0].value #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def register_container_instance(params = {}, options = {})
        req = build_request(:register_container_instance, params)
        req.send_request(options)
      end

      # Registers a new task definition from the supplied `family` and
      # `containerDefinitions`. Optionally, you can add data volumes to your
      # containers with the `volumes` parameter. For more information about
      # task definition parameters and defaults, see [Amazon ECS Task
      # Definitions][1] in the *Amazon EC2 Container Service Developer Guide*.
      #
      # You may also specify an IAM role for your task with the `taskRoleArn`
      # parameter. When you specify an IAM role for a task, its containers can
      # then use the latest versions of the AWS CLI or SDKs to make API
      # requests to the AWS services that are specified in the IAM policy
      # associated with the role. For more information, see [IAM Roles for
      # Tasks][2] in the *Amazon EC2 Container Service Developer Guide*.
      #
      #
      #
      # [1]: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_defintions.html
      # [2]: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html
      # @option params [required, String] :family
      #   You must specify a `family` for a task definition, which allows you to
      #   track multiple versions of the same task definition. The `family` is
      #   used as a name for your task definition. Up to 255 letters (uppercase
      #   and lowercase), numbers, hyphens, and underscores are allowed.
      # @option params [String] :task_role_arn
      #   The Amazon Resource Name (ARN) of the IAM role that containers in this
      #   task can assume. All containers in this task are granted the
      #   permissions that are specified in this role.
      # @option params [required, Array<Types::ContainerDefinition>] :container_definitions
      #   A list of container definitions in JSON format that describe the
      #   different containers that make up your task.
      # @option params [Array<Types::Volume>] :volumes
      #   A list of volume definitions in JSON format that containers in your
      #   task may use.
      # @return [Types::RegisterTaskDefinitionResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::RegisterTaskDefinitionResponse#task_definition #taskDefinition} => Types::TaskDefinition
      #
      # @example Request syntax with placeholder values
      #   resp = client.register_task_definition({
      #     family: "String", # required
      #     task_role_arn: "String",
      #     container_definitions: [ # required
      #       {
      #         name: "String",
      #         image: "String",
      #         cpu: 1,
      #         memory: 1,
      #         links: ["String"],
      #         port_mappings: [
      #           {
      #             container_port: 1,
      #             host_port: 1,
      #             protocol: "tcp", # accepts tcp, udp
      #           },
      #         ],
      #         essential: false,
      #         entry_point: ["String"],
      #         command: ["String"],
      #         environment: [
      #           {
      #             name: "String",
      #             value: "String",
      #           },
      #         ],
      #         mount_points: [
      #           {
      #             source_volume: "String",
      #             container_path: "String",
      #             read_only: false,
      #           },
      #         ],
      #         volumes_from: [
      #           {
      #             source_container: "String",
      #             read_only: false,
      #           },
      #         ],
      #         hostname: "String",
      #         user: "String",
      #         working_directory: "String",
      #         disable_networking: false,
      #         privileged: false,
      #         readonly_root_filesystem: false,
      #         dns_servers: ["String"],
      #         dns_search_domains: ["String"],
      #         extra_hosts: [
      #           {
      #             hostname: "String", # required
      #             ip_address: "String", # required
      #           },
      #         ],
      #         docker_security_options: ["String"],
      #         docker_labels: {
      #           "String" => "String",
      #         },
      #         ulimits: [
      #           {
      #             name: "core", # required, accepts core, cpu, data, fsize, locks, memlock, msgqueue, nice, nofile, nproc, rss, rtprio, rttime, sigpending, stack
      #             soft_limit: 1, # required
      #             hard_limit: 1, # required
      #           },
      #         ],
      #         log_configuration: {
      #           log_driver: "json-file", # required, accepts json-file, syslog, journald, gelf, fluentd, awslogs
      #           options: {
      #             "String" => "String",
      #           },
      #         },
      #       },
      #     ],
      #     volumes: [
      #       {
      #         name: "String",
      #         host: {
      #           source_path: "String",
      #         },
      #       },
      #     ],
      #   })
      #
      # @example Response structure
      #   resp.task_definition.task_definition_arn #=> String
      #   resp.task_definition.container_definitions #=> Array
      #   resp.task_definition.container_definitions[0].name #=> String
      #   resp.task_definition.container_definitions[0].image #=> String
      #   resp.task_definition.container_definitions[0].cpu #=> Integer
      #   resp.task_definition.container_definitions[0].memory #=> Integer
      #   resp.task_definition.container_definitions[0].links #=> Array
      #   resp.task_definition.container_definitions[0].links[0] #=> String
      #   resp.task_definition.container_definitions[0].port_mappings #=> Array
      #   resp.task_definition.container_definitions[0].port_mappings[0].container_port #=> Integer
      #   resp.task_definition.container_definitions[0].port_mappings[0].host_port #=> Integer
      #   resp.task_definition.container_definitions[0].port_mappings[0].protocol #=> String, one of "tcp", "udp"
      #   resp.task_definition.container_definitions[0].essential #=> Boolean
      #   resp.task_definition.container_definitions[0].entry_point #=> Array
      #   resp.task_definition.container_definitions[0].entry_point[0] #=> String
      #   resp.task_definition.container_definitions[0].command #=> Array
      #   resp.task_definition.container_definitions[0].command[0] #=> String
      #   resp.task_definition.container_definitions[0].environment #=> Array
      #   resp.task_definition.container_definitions[0].environment[0].name #=> String
      #   resp.task_definition.container_definitions[0].environment[0].value #=> String
      #   resp.task_definition.container_definitions[0].mount_points #=> Array
      #   resp.task_definition.container_definitions[0].mount_points[0].source_volume #=> String
      #   resp.task_definition.container_definitions[0].mount_points[0].container_path #=> String
      #   resp.task_definition.container_definitions[0].mount_points[0].read_only #=> Boolean
      #   resp.task_definition.container_definitions[0].volumes_from #=> Array
      #   resp.task_definition.container_definitions[0].volumes_from[0].source_container #=> String
      #   resp.task_definition.container_definitions[0].volumes_from[0].read_only #=> Boolean
      #   resp.task_definition.container_definitions[0].hostname #=> String
      #   resp.task_definition.container_definitions[0].user #=> String
      #   resp.task_definition.container_definitions[0].working_directory #=> String
      #   resp.task_definition.container_definitions[0].disable_networking #=> Boolean
      #   resp.task_definition.container_definitions[0].privileged #=> Boolean
      #   resp.task_definition.container_definitions[0].readonly_root_filesystem #=> Boolean
      #   resp.task_definition.container_definitions[0].dns_servers #=> Array
      #   resp.task_definition.container_definitions[0].dns_servers[0] #=> String
      #   resp.task_definition.container_definitions[0].dns_search_domains #=> Array
      #   resp.task_definition.container_definitions[0].dns_search_domains[0] #=> String
      #   resp.task_definition.container_definitions[0].extra_hosts #=> Array
      #   resp.task_definition.container_definitions[0].extra_hosts[0].hostname #=> String
      #   resp.task_definition.container_definitions[0].extra_hosts[0].ip_address #=> String
      #   resp.task_definition.container_definitions[0].docker_security_options #=> Array
      #   resp.task_definition.container_definitions[0].docker_security_options[0] #=> String
      #   resp.task_definition.container_definitions[0].docker_labels #=> Hash
      #   resp.task_definition.container_definitions[0].docker_labels["String"] #=> String
      #   resp.task_definition.container_definitions[0].ulimits #=> Array
      #   resp.task_definition.container_definitions[0].ulimits[0].name #=> String, one of "core", "cpu", "data", "fsize", "locks", "memlock", "msgqueue", "nice", "nofile", "nproc", "rss", "rtprio", "rttime", "sigpending", "stack"
      #   resp.task_definition.container_definitions[0].ulimits[0].soft_limit #=> Integer
      #   resp.task_definition.container_definitions[0].ulimits[0].hard_limit #=> Integer
      #   resp.task_definition.container_definitions[0].log_configuration.log_driver #=> String, one of "json-file", "syslog", "journald", "gelf", "fluentd", "awslogs"
      #   resp.task_definition.container_definitions[0].log_configuration.options #=> Hash
      #   resp.task_definition.container_definitions[0].log_configuration.options["String"] #=> String
      #   resp.task_definition.family #=> String
      #   resp.task_definition.task_role_arn #=> String
      #   resp.task_definition.revision #=> Integer
      #   resp.task_definition.volumes #=> Array
      #   resp.task_definition.volumes[0].name #=> String
      #   resp.task_definition.volumes[0].host.source_path #=> String
      #   resp.task_definition.status #=> String, one of "ACTIVE", "INACTIVE"
      #   resp.task_definition.requires_attributes #=> Array
      #   resp.task_definition.requires_attributes[0].name #=> String
      #   resp.task_definition.requires_attributes[0].value #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def register_task_definition(params = {}, options = {})
        req = build_request(:register_task_definition, params)
        req.send_request(options)
      end

      # Start a task using random placement and the default Amazon ECS
      # scheduler. To use your own scheduler or place a task on a specific
      # container instance, use `StartTask` instead.
      #
      # <important markdown="1"> The `count` parameter is limited to 10 tasks per call.
      #
      #  </important>
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster on
      #   which to run your task. If you do not specify a cluster, the default
      #   cluster is assumed..
      # @option params [required, String] :task_definition
      #   The `family` and `revision` (`family:revision`) or full Amazon
      #   Resource Name (ARN) of the task definition to run. If a `revision` is
      #   not specified, the latest `ACTIVE` revision is used.
      # @option params [Types::TaskOverride] :overrides
      #   A list of container overrides in JSON format that specify the name of
      #   a container in the specified task definition and the overrides it
      #   should receive. You can override the default command for a container
      #   (that is specified in the task definition or Docker image) with a
      #   `command` override. You can also override existing environment
      #   variables (that are specified in the task definition or Docker image)
      #   on a container or add new environment variables to it with an
      #   `environment` override.
      #
      #   <note markdown="1"> A total of 8192 characters are allowed for overrides. This limit
      #   includes the JSON formatting characters of the override structure.
      #
      #    </note>
      # @option params [Integer] :count
      #   The number of instantiations of the specified task to place on your
      #   cluster.
      #
      #   <important markdown="1"> The `count` parameter is limited to 10 tasks per call.
      #
      #    </important>
      # @option params [String] :started_by
      #   An optional tag specified when a task is started. For example if you
      #   automatically trigger a task to run a batch process job, you could
      #   apply a unique identifier for that job to your task with the
      #   `startedBy` parameter. You can then identify which tasks belong to
      #   that job by filtering the results of a ListTasks call with the
      #   `startedBy` value. Up to 36 letters (uppercase and lowercase),
      #   numbers, hyphens, and underscores are allowed.
      #
      #   If a task is started by an Amazon ECS service, then the `startedBy`
      #   parameter contains the deployment ID of the service that starts it.
      # @return [Types::RunTaskResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::RunTaskResponse#tasks #tasks} => Array&lt;Types::Task&gt;
      #   * {Types::RunTaskResponse#failures #failures} => Array&lt;Types::Failure&gt;
      #
      # @example Request syntax with placeholder values
      #   resp = client.run_task({
      #     cluster: "String",
      #     task_definition: "String", # required
      #     overrides: {
      #       container_overrides: [
      #         {
      #           name: "String",
      #           command: ["String"],
      #           environment: [
      #             {
      #               name: "String",
      #               value: "String",
      #             },
      #           ],
      #         },
      #       ],
      #       task_role_arn: "String",
      #     },
      #     count: 1,
      #     started_by: "String",
      #   })
      #
      # @example Response structure
      #   resp.tasks #=> Array
      #   resp.tasks[0].task_arn #=> String
      #   resp.tasks[0].cluster_arn #=> String
      #   resp.tasks[0].task_definition_arn #=> String
      #   resp.tasks[0].container_instance_arn #=> String
      #   resp.tasks[0].overrides.container_overrides #=> Array
      #   resp.tasks[0].overrides.container_overrides[0].name #=> String
      #   resp.tasks[0].overrides.container_overrides[0].command #=> Array
      #   resp.tasks[0].overrides.container_overrides[0].command[0] #=> String
      #   resp.tasks[0].overrides.container_overrides[0].environment #=> Array
      #   resp.tasks[0].overrides.container_overrides[0].environment[0].name #=> String
      #   resp.tasks[0].overrides.container_overrides[0].environment[0].value #=> String
      #   resp.tasks[0].overrides.task_role_arn #=> String
      #   resp.tasks[0].last_status #=> String
      #   resp.tasks[0].desired_status #=> String
      #   resp.tasks[0].containers #=> Array
      #   resp.tasks[0].containers[0].container_arn #=> String
      #   resp.tasks[0].containers[0].task_arn #=> String
      #   resp.tasks[0].containers[0].name #=> String
      #   resp.tasks[0].containers[0].last_status #=> String
      #   resp.tasks[0].containers[0].exit_code #=> Integer
      #   resp.tasks[0].containers[0].reason #=> String
      #   resp.tasks[0].containers[0].network_bindings #=> Array
      #   resp.tasks[0].containers[0].network_bindings[0].bind_ip #=> String
      #   resp.tasks[0].containers[0].network_bindings[0].container_port #=> Integer
      #   resp.tasks[0].containers[0].network_bindings[0].host_port #=> Integer
      #   resp.tasks[0].containers[0].network_bindings[0].protocol #=> String, one of "tcp", "udp"
      #   resp.tasks[0].started_by #=> String
      #   resp.tasks[0].stopped_reason #=> String
      #   resp.tasks[0].created_at #=> Time
      #   resp.tasks[0].started_at #=> Time
      #   resp.tasks[0].stopped_at #=> Time
      #   resp.failures #=> Array
      #   resp.failures[0].arn #=> String
      #   resp.failures[0].reason #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def run_task(params = {}, options = {})
        req = build_request(:run_task, params)
        req.send_request(options)
      end

      # Starts a new task from the specified task definition on the specified
      # container instance or instances. To use the default Amazon ECS
      # scheduler to place your task, use `RunTask` instead.
      #
      # <important markdown="1"> The list of container instances to start tasks on is limited to 10.
      #
      #  </important>
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster on
      #   which to start your task. If you do not specify a cluster, the default
      #   cluster is assumed..
      # @option params [required, String] :task_definition
      #   The `family` and `revision` (`family:revision`) or full Amazon
      #   Resource Name (ARN) of the task definition to start. If a `revision`
      #   is not specified, the latest `ACTIVE` revision is used.
      # @option params [Types::TaskOverride] :overrides
      #   A list of container overrides in JSON format that specify the name of
      #   a container in the specified task definition and the overrides it
      #   should receive. You can override the default command for a container
      #   (that is specified in the task definition or Docker image) with a
      #   `command` override. You can also override existing environment
      #   variables (that are specified in the task definition or Docker image)
      #   on a container or add new environment variables to it with an
      #   `environment` override.
      #
      #   <note markdown="1"> A total of 8192 characters are allowed for overrides. This limit
      #   includes the JSON formatting characters of the override structure.
      #
      #    </note>
      # @option params [required, Array<String>] :container_instances
      #   The container instance IDs or full Amazon Resource Name (ARN) entries
      #   for the container instances on which you would like to place your
      #   task.
      #
      #   <important markdown="1"> The list of container instances to start tasks on is limited to 10.
      #
      #    </important>
      # @option params [String] :started_by
      #   An optional tag specified when a task is started. For example if you
      #   automatically trigger a task to run a batch process job, you could
      #   apply a unique identifier for that job to your task with the
      #   `startedBy` parameter. You can then identify which tasks belong to
      #   that job by filtering the results of a ListTasks call with the
      #   `startedBy` value. Up to 36 letters (uppercase and lowercase),
      #   numbers, hyphens, and underscores are allowed.
      #
      #   If a task is started by an Amazon ECS service, then the `startedBy`
      #   parameter contains the deployment ID of the service that starts it.
      # @return [Types::StartTaskResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::StartTaskResponse#tasks #tasks} => Array&lt;Types::Task&gt;
      #   * {Types::StartTaskResponse#failures #failures} => Array&lt;Types::Failure&gt;
      #
      # @example Request syntax with placeholder values
      #   resp = client.start_task({
      #     cluster: "String",
      #     task_definition: "String", # required
      #     overrides: {
      #       container_overrides: [
      #         {
      #           name: "String",
      #           command: ["String"],
      #           environment: [
      #             {
      #               name: "String",
      #               value: "String",
      #             },
      #           ],
      #         },
      #       ],
      #       task_role_arn: "String",
      #     },
      #     container_instances: ["String"], # required
      #     started_by: "String",
      #   })
      #
      # @example Response structure
      #   resp.tasks #=> Array
      #   resp.tasks[0].task_arn #=> String
      #   resp.tasks[0].cluster_arn #=> String
      #   resp.tasks[0].task_definition_arn #=> String
      #   resp.tasks[0].container_instance_arn #=> String
      #   resp.tasks[0].overrides.container_overrides #=> Array
      #   resp.tasks[0].overrides.container_overrides[0].name #=> String
      #   resp.tasks[0].overrides.container_overrides[0].command #=> Array
      #   resp.tasks[0].overrides.container_overrides[0].command[0] #=> String
      #   resp.tasks[0].overrides.container_overrides[0].environment #=> Array
      #   resp.tasks[0].overrides.container_overrides[0].environment[0].name #=> String
      #   resp.tasks[0].overrides.container_overrides[0].environment[0].value #=> String
      #   resp.tasks[0].overrides.task_role_arn #=> String
      #   resp.tasks[0].last_status #=> String
      #   resp.tasks[0].desired_status #=> String
      #   resp.tasks[0].containers #=> Array
      #   resp.tasks[0].containers[0].container_arn #=> String
      #   resp.tasks[0].containers[0].task_arn #=> String
      #   resp.tasks[0].containers[0].name #=> String
      #   resp.tasks[0].containers[0].last_status #=> String
      #   resp.tasks[0].containers[0].exit_code #=> Integer
      #   resp.tasks[0].containers[0].reason #=> String
      #   resp.tasks[0].containers[0].network_bindings #=> Array
      #   resp.tasks[0].containers[0].network_bindings[0].bind_ip #=> String
      #   resp.tasks[0].containers[0].network_bindings[0].container_port #=> Integer
      #   resp.tasks[0].containers[0].network_bindings[0].host_port #=> Integer
      #   resp.tasks[0].containers[0].network_bindings[0].protocol #=> String, one of "tcp", "udp"
      #   resp.tasks[0].started_by #=> String
      #   resp.tasks[0].stopped_reason #=> String
      #   resp.tasks[0].created_at #=> Time
      #   resp.tasks[0].started_at #=> Time
      #   resp.tasks[0].stopped_at #=> Time
      #   resp.failures #=> Array
      #   resp.failures[0].arn #=> String
      #   resp.failures[0].reason #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def start_task(params = {}, options = {})
        req = build_request(:start_task, params)
        req.send_request(options)
      end

      # Stops a running task.
      #
      # When StopTask is called on a task, the equivalent of `docker stop` is
      # issued to the containers running in the task. This results in a
      # `SIGTERM` and a 30-second timeout, after which `SIGKILL` is sent and
      # the containers are forcibly stopped. If the container handles the
      # `SIGTERM` gracefully and exits within 30 seconds from receiving it, no
      # `SIGKILL` is sent.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   hosts the task to stop. If you do not specify a cluster, the default
      #   cluster is assumed..
      # @option params [required, String] :task
      #   The task ID or full Amazon Resource Name (ARN) entry of the task to
      #   stop.
      # @option params [String] :reason
      #   An optional message specified when a task is stopped. For example, if
      #   you are using a custom scheduler, you can use this parameter to
      #   specify the reason for stopping the task here, and the message will
      #   appear in subsequent DescribeTasks API operations on this task. Up to
      #   255 characters are allowed in this message.
      # @return [Types::StopTaskResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::StopTaskResponse#task #task} => Types::Task
      #
      # @example Request syntax with placeholder values
      #   resp = client.stop_task({
      #     cluster: "String",
      #     task: "String", # required
      #     reason: "String",
      #   })
      #
      # @example Response structure
      #   resp.task.task_arn #=> String
      #   resp.task.cluster_arn #=> String
      #   resp.task.task_definition_arn #=> String
      #   resp.task.container_instance_arn #=> String
      #   resp.task.overrides.container_overrides #=> Array
      #   resp.task.overrides.container_overrides[0].name #=> String
      #   resp.task.overrides.container_overrides[0].command #=> Array
      #   resp.task.overrides.container_overrides[0].command[0] #=> String
      #   resp.task.overrides.container_overrides[0].environment #=> Array
      #   resp.task.overrides.container_overrides[0].environment[0].name #=> String
      #   resp.task.overrides.container_overrides[0].environment[0].value #=> String
      #   resp.task.overrides.task_role_arn #=> String
      #   resp.task.last_status #=> String
      #   resp.task.desired_status #=> String
      #   resp.task.containers #=> Array
      #   resp.task.containers[0].container_arn #=> String
      #   resp.task.containers[0].task_arn #=> String
      #   resp.task.containers[0].name #=> String
      #   resp.task.containers[0].last_status #=> String
      #   resp.task.containers[0].exit_code #=> Integer
      #   resp.task.containers[0].reason #=> String
      #   resp.task.containers[0].network_bindings #=> Array
      #   resp.task.containers[0].network_bindings[0].bind_ip #=> String
      #   resp.task.containers[0].network_bindings[0].container_port #=> Integer
      #   resp.task.containers[0].network_bindings[0].host_port #=> Integer
      #   resp.task.containers[0].network_bindings[0].protocol #=> String, one of "tcp", "udp"
      #   resp.task.started_by #=> String
      #   resp.task.stopped_reason #=> String
      #   resp.task.created_at #=> Time
      #   resp.task.started_at #=> Time
      #   resp.task.stopped_at #=> Time
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def stop_task(params = {}, options = {})
        req = build_request(:stop_task, params)
        req.send_request(options)
      end

      # <note markdown="1"> This action is only used by the Amazon EC2 Container Service agent,
      # and it is not intended for use outside of the agent.
      #
      #  </note>
      #
      # Sent to acknowledge that a container changed states.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   hosts the container.
      # @option params [String] :task
      #   The task ID or full Amazon Resource Name (ARN) of the task that hosts
      #   the container.
      # @option params [String] :container_name
      #   The name of the container.
      # @option params [String] :status
      #   The status of the state change request.
      # @option params [Integer] :exit_code
      #   The exit code returned for the state change request.
      # @option params [String] :reason
      #   The reason for the state change request.
      # @option params [Array<Types::NetworkBinding>] :network_bindings
      #   The network bindings of the container.
      # @return [Types::SubmitContainerStateChangeResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::SubmitContainerStateChangeResponse#acknowledgment #acknowledgment} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.submit_container_state_change({
      #     cluster: "String",
      #     task: "String",
      #     container_name: "String",
      #     status: "String",
      #     exit_code: 1,
      #     reason: "String",
      #     network_bindings: [
      #       {
      #         bind_ip: "String",
      #         container_port: 1,
      #         host_port: 1,
      #         protocol: "tcp", # accepts tcp, udp
      #       },
      #     ],
      #   })
      #
      # @example Response structure
      #   resp.acknowledgment #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def submit_container_state_change(params = {}, options = {})
        req = build_request(:submit_container_state_change, params)
        req.send_request(options)
      end

      # <note markdown="1"> This action is only used by the Amazon EC2 Container Service agent,
      # and it is not intended for use outside of the agent.
      #
      #  </note>
      #
      # Sent to acknowledge that a task changed states.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   hosts the task.
      # @option params [String] :task
      #   The task ID or full Amazon Resource Name (ARN) of the task in the
      #   state change request.
      # @option params [String] :status
      #   The status of the state change request.
      # @option params [String] :reason
      #   The reason for the state change request.
      # @return [Types::SubmitTaskStateChangeResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::SubmitTaskStateChangeResponse#acknowledgment #acknowledgment} => String
      #
      # @example Request syntax with placeholder values
      #   resp = client.submit_task_state_change({
      #     cluster: "String",
      #     task: "String",
      #     status: "String",
      #     reason: "String",
      #   })
      #
      # @example Response structure
      #   resp.acknowledgment #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def submit_task_state_change(params = {}, options = {})
        req = build_request(:submit_task_state_change, params)
        req.send_request(options)
      end

      # Updates the Amazon ECS container agent on a specified container
      # instance. Updating the Amazon ECS container agent does not interrupt
      # running tasks or services on the container instance. The process for
      # updating the agent differs depending on whether your container
      # instance was launched with the Amazon ECS-optimized AMI or another
      # operating system.
      #
      # `UpdateContainerAgent` requires the Amazon ECS-optimized AMI or Amazon
      # Linux with the `ecs-init` service installed and running. For help
      # updating the Amazon ECS container agent on other operating systems,
      # see [Manually Updating the Amazon ECS Container Agent][1] in the
      # *Amazon EC2 Container Service Developer Guide*.
      #
      #
      #
      # [1]: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html#manually_update_agent
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   your container instance is running on. If you do not specify a
      #   cluster, the default cluster is assumed.
      # @option params [required, String] :container_instance
      #   The container instance ID or full Amazon Resource Name (ARN) entries
      #   for the container instance on which you would like to update the
      #   Amazon ECS container agent.
      # @return [Types::UpdateContainerAgentResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::UpdateContainerAgentResponse#container_instance #containerInstance} => Types::ContainerInstance
      #
      # @example Request syntax with placeholder values
      #   resp = client.update_container_agent({
      #     cluster: "String",
      #     container_instance: "String", # required
      #   })
      #
      # @example Response structure
      #   resp.container_instance.container_instance_arn #=> String
      #   resp.container_instance.ec2_instance_id #=> String
      #   resp.container_instance.version_info.agent_version #=> String
      #   resp.container_instance.version_info.agent_hash #=> String
      #   resp.container_instance.version_info.docker_version #=> String
      #   resp.container_instance.remaining_resources #=> Array
      #   resp.container_instance.remaining_resources[0].name #=> String
      #   resp.container_instance.remaining_resources[0].type #=> String
      #   resp.container_instance.remaining_resources[0].double_value #=> Float
      #   resp.container_instance.remaining_resources[0].long_value #=> Integer
      #   resp.container_instance.remaining_resources[0].integer_value #=> Integer
      #   resp.container_instance.remaining_resources[0].string_set_value #=> Array
      #   resp.container_instance.remaining_resources[0].string_set_value[0] #=> String
      #   resp.container_instance.registered_resources #=> Array
      #   resp.container_instance.registered_resources[0].name #=> String
      #   resp.container_instance.registered_resources[0].type #=> String
      #   resp.container_instance.registered_resources[0].double_value #=> Float
      #   resp.container_instance.registered_resources[0].long_value #=> Integer
      #   resp.container_instance.registered_resources[0].integer_value #=> Integer
      #   resp.container_instance.registered_resources[0].string_set_value #=> Array
      #   resp.container_instance.registered_resources[0].string_set_value[0] #=> String
      #   resp.container_instance.status #=> String
      #   resp.container_instance.agent_connected #=> Boolean
      #   resp.container_instance.running_tasks_count #=> Integer
      #   resp.container_instance.pending_tasks_count #=> Integer
      #   resp.container_instance.agent_update_status #=> String, one of "PENDING", "STAGING", "STAGED", "UPDATING", "UPDATED", "FAILED"
      #   resp.container_instance.attributes #=> Array
      #   resp.container_instance.attributes[0].name #=> String
      #   resp.container_instance.attributes[0].value #=> String
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def update_container_agent(params = {}, options = {})
        req = build_request(:update_container_agent, params)
        req.send_request(options)
      end

      # Modifies the desired count, deployment configuration, or task
      # definition used in a service.
      #
      # You can add to or subtract from the number of instantiations of a task
      # definition in a service by specifying the cluster that the service is
      # running in and a new `desiredCount` parameter.
      #
      # You can use UpdateService to modify your task definition and deploy a
      # new version of your service.
      #
      # You can also update the deployment configuration of a service. When a
      # deployment is triggered by updating the task definition of a service,
      # the service scheduler uses the deployment configuration parameters,
      # `minimumHealthyPercent` and `maximumPercent`, to determine the
      # deployment strategy.
      #
      # If the `minimumHealthyPercent` is below 100%, the scheduler can ignore
      # the `desiredCount` temporarily during a deployment. For example, if
      # your service has a `desiredCount` of four tasks, a
      # `minimumHealthyPercent` of 50% allows the scheduler to stop two
      # existing tasks before starting two new tasks. Tasks for services that
      # *do not* use a load balancer are considered healthy if they are in the
      # `RUNNING` state; tasks for services that *do* use a load balancer are
      # considered healthy if they are in the `RUNNING` state and the
      # container instance it is hosted on is reported as healthy by the load
      # balancer.
      #
      # The `maximumPercent` parameter represents an upper limit on the number
      # of running tasks during a deployment, which enables you to define the
      # deployment batch size. For example, if your service has a
      # `desiredCount` of four tasks, a `maximumPercent` value of 200% starts
      # four new tasks before stopping the four older tasks (provided that the
      # cluster resources required to do this are available).
      #
      # When UpdateService stops a task during a deployment, the equivalent of
      # `docker stop` is issued to the containers running in the task. This
      # results in a `SIGTERM` and a 30-second timeout, after which `SIGKILL`
      # is sent and the containers are forcibly stopped. If the container
      # handles the `SIGTERM` gracefully and exits within 30 seconds from
      # receiving it, no `SIGKILL` is sent.
      #
      # When the service scheduler launches new tasks, it attempts to balance
      # them across the Availability Zones in your cluster with the following
      # logic:
      #
      # * Determine which of the container instances in your cluster can
      #   support your service\'s task definition (for example, they have the
      #   required CPU, memory, ports, and container instance attributes).
      #
      # * Sort the valid container instances by the fewest number of running
      #   tasks for this service in the same Availability Zone as the
      #   instance. For example, if zone A has one running service task and
      #   zones B and C each have zero, valid container instances in either
      #   zone B or C are considered optimal for placement.
      #
      # * Place the new service task on a valid container instance in an
      #   optimal Availability Zone (based on the previous steps), favoring
      #   container instances with the fewest number of running tasks for this
      #   service.
      # @option params [String] :cluster
      #   The short name or full Amazon Resource Name (ARN) of the cluster that
      #   your service is running on. If you do not specify a cluster, the
      #   default cluster is assumed.
      # @option params [required, String] :service
      #   The name of the service to update.
      # @option params [Integer] :desired_count
      #   The number of instantiations of the task to place and keep running in
      #   your service.
      # @option params [String] :task_definition
      #   The `family` and `revision` (`family:revision`) or full Amazon
      #   Resource Name (ARN) of the task definition to run in your service. If
      #   a `revision` is not specified, the latest `ACTIVE` revision is used.
      #   If you modify the task definition with `UpdateService`, Amazon ECS
      #   spawns a task with the new version of the task definition and then
      #   stops an old task after the new version is running.
      # @option params [Types::DeploymentConfiguration] :deployment_configuration
      #   Optional deployment parameters that control how many tasks run during
      #   the deployment and the ordering of stopping and starting tasks.
      # @return [Types::UpdateServiceResponse] Returns a {Seahorse::Client::Response response} object which responds to the following methods:
      #
      #   * {Types::UpdateServiceResponse#service #service} => Types::Service
      #
      # @example Request syntax with placeholder values
      #   resp = client.update_service({
      #     cluster: "String",
      #     service: "String", # required
      #     desired_count: 1,
      #     task_definition: "String",
      #     deployment_configuration: {
      #       maximum_percent: 1,
      #       minimum_healthy_percent: 1,
      #     },
      #   })
      #
      # @example Response structure
      #   resp.service.service_arn #=> String
      #   resp.service.service_name #=> String
      #   resp.service.cluster_arn #=> String
      #   resp.service.load_balancers #=> Array
      #   resp.service.load_balancers[0].load_balancer_name #=> String
      #   resp.service.load_balancers[0].container_name #=> String
      #   resp.service.load_balancers[0].container_port #=> Integer
      #   resp.service.status #=> String
      #   resp.service.desired_count #=> Integer
      #   resp.service.running_count #=> Integer
      #   resp.service.pending_count #=> Integer
      #   resp.service.task_definition #=> String
      #   resp.service.deployment_configuration.maximum_percent #=> Integer
      #   resp.service.deployment_configuration.minimum_healthy_percent #=> Integer
      #   resp.service.deployments #=> Array
      #   resp.service.deployments[0].id #=> String
      #   resp.service.deployments[0].status #=> String
      #   resp.service.deployments[0].task_definition #=> String
      #   resp.service.deployments[0].desired_count #=> Integer
      #   resp.service.deployments[0].pending_count #=> Integer
      #   resp.service.deployments[0].running_count #=> Integer
      #   resp.service.deployments[0].created_at #=> Time
      #   resp.service.deployments[0].updated_at #=> Time
      #   resp.service.role_arn #=> String
      #   resp.service.events #=> Array
      #   resp.service.events[0].id #=> String
      #   resp.service.events[0].created_at #=> Time
      #   resp.service.events[0].message #=> String
      #   resp.service.created_at #=> Time
      # @param [Hash] params ({})
      # @param [Hash] options ({})
      def update_service(params = {}, options = {})
        req = build_request(:update_service, params)
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
        {
          tasks_running: Waiters::TasksRunning,
          tasks_stopped: Waiters::TasksStopped,
          services_stable: Waiters::ServicesStable,
          services_inactive: Waiters::ServicesInactive
        }
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
