# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing guide for more information:
# https://github.com/aws/aws-sdk-ruby/blob/version-3/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE


module Aws::ApplicationInsights
  module Plugins
    class Endpoints < Seahorse::Client::Plugin
      option(
        :endpoint_provider,
        doc_type: 'Aws::ApplicationInsights::EndpointProvider',
        docstring: 'The endpoint provider used to resolve endpoints. Any '\
                   'object that responds to `#resolve_endpoint(parameters)` '\
                   'where `parameters` is a Struct similar to '\
                   '`Aws::ApplicationInsights::EndpointParameters`'
      ) do |cfg|
        Aws::ApplicationInsights::EndpointProvider.new
      end

      # @api private
      class Handler < Seahorse::Client::Handler
        def call(context)
          unless context[:discovered_endpoint]
            params = parameters_for_operation(context)
            endpoint = context.config.endpoint_provider.resolve_endpoint(params)

            context.http_request.endpoint = endpoint.url
            apply_endpoint_headers(context, endpoint.headers)

            context[:endpoint_params] = params
            context[:endpoint_properties] = endpoint.properties
          end

          context[:auth_scheme] =
            Aws::Endpoints.resolve_auth_scheme(context, endpoint)

          @handler.call(context)
        end

        private

        def apply_endpoint_headers(context, headers)
          headers.each do |key, values|
            value = values
              .compact
              .map { |s| Seahorse::Util.escape_header_list_string(s.to_s) }
              .join(',')

            context.http_request.headers[key] = value
          end
        end

        def parameters_for_operation(context)
          case context.operation_name
          when :add_workload
            Aws::ApplicationInsights::Endpoints::AddWorkload.build(context)
          when :create_application
            Aws::ApplicationInsights::Endpoints::CreateApplication.build(context)
          when :create_component
            Aws::ApplicationInsights::Endpoints::CreateComponent.build(context)
          when :create_log_pattern
            Aws::ApplicationInsights::Endpoints::CreateLogPattern.build(context)
          when :delete_application
            Aws::ApplicationInsights::Endpoints::DeleteApplication.build(context)
          when :delete_component
            Aws::ApplicationInsights::Endpoints::DeleteComponent.build(context)
          when :delete_log_pattern
            Aws::ApplicationInsights::Endpoints::DeleteLogPattern.build(context)
          when :describe_application
            Aws::ApplicationInsights::Endpoints::DescribeApplication.build(context)
          when :describe_component
            Aws::ApplicationInsights::Endpoints::DescribeComponent.build(context)
          when :describe_component_configuration
            Aws::ApplicationInsights::Endpoints::DescribeComponentConfiguration.build(context)
          when :describe_component_configuration_recommendation
            Aws::ApplicationInsights::Endpoints::DescribeComponentConfigurationRecommendation.build(context)
          when :describe_log_pattern
            Aws::ApplicationInsights::Endpoints::DescribeLogPattern.build(context)
          when :describe_observation
            Aws::ApplicationInsights::Endpoints::DescribeObservation.build(context)
          when :describe_problem
            Aws::ApplicationInsights::Endpoints::DescribeProblem.build(context)
          when :describe_problem_observations
            Aws::ApplicationInsights::Endpoints::DescribeProblemObservations.build(context)
          when :describe_workload
            Aws::ApplicationInsights::Endpoints::DescribeWorkload.build(context)
          when :list_applications
            Aws::ApplicationInsights::Endpoints::ListApplications.build(context)
          when :list_components
            Aws::ApplicationInsights::Endpoints::ListComponents.build(context)
          when :list_configuration_history
            Aws::ApplicationInsights::Endpoints::ListConfigurationHistory.build(context)
          when :list_log_pattern_sets
            Aws::ApplicationInsights::Endpoints::ListLogPatternSets.build(context)
          when :list_log_patterns
            Aws::ApplicationInsights::Endpoints::ListLogPatterns.build(context)
          when :list_problems
            Aws::ApplicationInsights::Endpoints::ListProblems.build(context)
          when :list_tags_for_resource
            Aws::ApplicationInsights::Endpoints::ListTagsForResource.build(context)
          when :list_workloads
            Aws::ApplicationInsights::Endpoints::ListWorkloads.build(context)
          when :remove_workload
            Aws::ApplicationInsights::Endpoints::RemoveWorkload.build(context)
          when :tag_resource
            Aws::ApplicationInsights::Endpoints::TagResource.build(context)
          when :untag_resource
            Aws::ApplicationInsights::Endpoints::UntagResource.build(context)
          when :update_application
            Aws::ApplicationInsights::Endpoints::UpdateApplication.build(context)
          when :update_component
            Aws::ApplicationInsights::Endpoints::UpdateComponent.build(context)
          when :update_component_configuration
            Aws::ApplicationInsights::Endpoints::UpdateComponentConfiguration.build(context)
          when :update_log_pattern
            Aws::ApplicationInsights::Endpoints::UpdateLogPattern.build(context)
          when :update_problem
            Aws::ApplicationInsights::Endpoints::UpdateProblem.build(context)
          when :update_workload
            Aws::ApplicationInsights::Endpoints::UpdateWorkload.build(context)
          end
        end
      end

      def add_handlers(handlers, _config)
        handlers.add(Handler, step: :build, priority: 75)
      end
    end
  end
end
