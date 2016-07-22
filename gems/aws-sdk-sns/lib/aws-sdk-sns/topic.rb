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
  module SNS
    class Topic

      extend Aws::Deprecations

      # @overload def initialize(arn, options = {})
      #   @param [String] arn
      #   @option options [Client] :client
      # @overload def initialize(options = {})
      #   @option options [required, String] :arn
      #   @option options [Client] :client
      def initialize(*args)
        options = Hash === args.last ? args.pop.dup : {}
        @arn = extract_arn(args, options)
        @data = options.delete(:data)
        @client = options.delete(:client) || Client.new(options)
      end

      # @!group Read-Only Attributes

      # @return [String]
      def arn
        @arn
      end

      # A map of the topic\'s attributes. Attributes in this map include the
      # following:
      #
      # * `TopicArn` -- the topic\'s ARN
      #
      # * `Owner` -- the AWS account ID of the topic\'s owner
      #
      # * `Policy` -- the JSON serialization of the topic\'s access control
      #   policy
      #
      # * `DisplayName` -- the human-readable name used in the \"From\" field
      #   for notifications to email and email-json endpoints
      #
      # * `SubscriptionsPending` -- the number of subscriptions pending
      #   confirmation on this topic
      #
      # * `SubscriptionsConfirmed` -- the number of confirmed subscriptions on
      #   this topic
      #
      # * `SubscriptionsDeleted` -- the number of deleted subscriptions on
      #   this topic
      #
      # * `DeliveryPolicy` -- the JSON serialization of the topic\'s delivery
      #   policy
      #
      # * `EffectiveDeliveryPolicy` -- the JSON serialization of the effective
      #   delivery policy that takes into account system defaults
      # @return [Hash<String,String>]
      def attributes
        data.attributes
      end

      # @!endgroup

      # @return [Client]
      def client
        @client
      end

      # Loads, or reloads {#data} for the current {Topic}.
      # Returns `self` making it possible to chain methods.
      #
      #     topic.reload.data
      #
      # @return [self]
      def load
        resp = @client.get_topic_attributes(topic_arn: @arn)
        @data = resp.data
        self
      end
      alias :reload :load

      # @return [Types::GetTopicAttributesResponse]
      #   Returns the data for this {Topic}. Calls
      #   {Client#get_topic_attributes} if {#data_loaded?} is `false`.
      def data
        load unless @data
        @data
      end

      # @return [Boolean]
      #   Returns `true` if this resource is loaded.  Accessing attributes or
      #   {#data} on an unloaded resource will trigger a call to {#load}.
      def data_loaded?
        !!@data
      end

      # @!group Actions

      # @param [Hash] options ({})
      # @option options [required, String] :label
      #   A unique identifier for the new policy statement.
      # @option options [required, Array<String>] :aws_account_id
      #   The AWS account IDs of the users (principals) who will be given access
      #   to the specified actions. The users must have AWS accounts, but do not
      #   need to be signed up for this service.
      # @option options [required, Array<String>] :action_name
      #   The action you want to allow for the specified principal(s).
      #
      #   Valid values: any Amazon SNS action name.
      # @return [EmptyStructure]
      def add_permission(options = {})
        options = options.merge(topic_arn: @arn)
        resp = @client.add_permission(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [required, String] :token
      #   Short-lived token sent to an endpoint during the `Subscribe` action.
      # @option options [String] :authenticate_on_unsubscribe
      #   Disallows unauthenticated unsubscribes of the subscription. If the
      #   value of this parameter is `true` and the request has an AWS
      #   signature, then only the topic owner and the subscription owner can
      #   unsubscribe the endpoint. The unsubscribe action requires AWS
      #   authentication.
      # @return [Subscription]
      def confirm_subscription(options = {})
        options = options.merge(topic_arn: @arn)
        resp = @client.confirm_subscription(options)
        Subscription.new(
          arn: resp.data.subscription_arn,
          client: @client
        )
      end

      # @param [Hash] options ({})
      # @return [EmptyStructure]
      def delete(options = {})
        options = options.merge(topic_arn: @arn)
        resp = @client.delete_topic(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [String] :target_arn
      #   Either TopicArn or EndpointArn, but not both.
      #
      #   If you don\'t specify a value for the `TargetArn` parameter, you must
      #   specify a value for the `PhoneNumber` or `TopicArn` parameters.
      # @option options [String] :phone_number
      #   The phone number to which you want to deliver an SMS message. Use
      #   E.164 format.
      #
      #   If you don\'t specify a value for the `PhoneNumber` parameter, you
      #   must specify a value for the `TargetArn` or `TopicArn` parameters.
      # @option options [required, String] :message
      #   The message you want to send to the topic.
      #
      #   If you want to send the same message to all transport protocols,
      #   include the text of the message as a String value.
      #
      #   If you want to send different messages for each transport protocol,
      #   set the value of the `MessageStructure` parameter to `json` and use a
      #   JSON object for the `Message` parameter. See the Examples section for
      #   the format of the JSON object.
      #
      #   Constraints: Messages must be UTF-8 encoded strings at most 256 KB in
      #   size (262144 bytes, not 262144 characters).
      #
      #   JSON-specific constraints:
      #
      #   * Keys in the JSON object that correspond to supported transport
      #     protocols must have simple JSON string values.
      #
      #   * The values will be parsed (unescaped) before they are used in
      #     outgoing messages.
      #
      #   * Outbound notifications are JSON encoded (meaning that the characters
      #     will be reescaped for sending).
      #
      #   * Values have a minimum length of 0 (the empty string, \"\", is
      #     allowed).
      #
      #   * Values have a maximum length bounded by the overall message size
      #     (so, including multiple protocols may limit message sizes).
      #
      #   * Non-string values will cause the key to be ignored.
      #
      #   * Keys that do not correspond to supported transport protocols are
      #     ignored.
      #
      #   * Duplicate keys are not allowed.
      #
      #   * Failure to parse or validate any key or value in the message will
      #     cause the `Publish` call to return an error (no partial delivery).
      # @option options [String] :subject
      #   Optional parameter to be used as the \"Subject\" line when the message
      #   is delivered to email endpoints. This field will also be included, if
      #   present, in the standard JSON messages delivered to other endpoints.
      #
      #   Constraints: Subjects must be ASCII text that begins with a letter,
      #   number, or punctuation mark; must not include line breaks or control
      #   characters; and must be less than 100 characters long.
      # @option options [String] :message_structure
      #   Set `MessageStructure` to `json` if you want to send a different
      #   message for each protocol. For example, using one publish action, you
      #   can send a short message to your SMS subscribers and a longer message
      #   to your email subscribers. If you set `MessageStructure` to `json`,
      #   the value of the `Message` parameter must:
      #
      #   * be a syntactically valid JSON object; and
      #
      #   * contain at least a top-level JSON key of \"default\" with a value
      #     that is a string.
      #
      #   You can define other top-level keys that define the message you want
      #   to send to a specific transport protocol (e.g., \"http\").
      #
      #   For information about sending different messages for each protocol
      #   using the AWS Management Console, go to [Create Different Messages for
      #   Each Protocol][1] in the *Amazon Simple Notification Service Getting
      #   Started Guide*.
      #
      #   Valid value: `json`
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/sns/latest/gsg/Publish.html#sns-message-formatting-by-protocol
      # @option options [Hash<String,Types::MessageAttributeValue>] :message_attributes
      #   Message attributes for Publish action.
      # @return [Types::PublishResponse]
      def publish(options = {})
        options = options.merge(topic_arn: @arn)
        resp = @client.publish(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [required, String] :label
      #   The unique label of the statement you want to remove.
      # @return [EmptyStructure]
      def remove_permission(options = {})
        options = options.merge(topic_arn: @arn)
        resp = @client.remove_permission(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [required, String] :attribute_name
      #   The name of the attribute you want to set. Only a subset of the
      #   topic\'s attributes are mutable.
      #
      #   Valid values: `Policy` \| `DisplayName` \| `DeliveryPolicy`
      # @option options [String] :attribute_value
      #   The new value for the attribute.
      # @return [EmptyStructure]
      def set_attributes(options = {})
        options = options.merge(topic_arn: @arn)
        resp = @client.set_topic_attributes(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [required, String] :protocol
      #   The protocol you want to use. Supported protocols include:
      #
      #   * `http` -- delivery of JSON-encoded message via HTTP POST
      #
      #   * `https` -- delivery of JSON-encoded message via HTTPS POST
      #
      #   * `email` -- delivery of message via SMTP
      #
      #   * `email-json` -- delivery of JSON-encoded message via SMTP
      #
      #   * `sms` -- delivery of message via SMS
      #
      #   * `sqs` -- delivery of JSON-encoded message to an Amazon SQS queue
      #
      #   * `application` -- delivery of JSON-encoded message to an EndpointArn
      #     for a mobile app and device.
      #
      #   * `lambda` -- delivery of JSON-encoded message to an AWS Lambda
      #     function.
      # @option options [String] :endpoint
      #   The endpoint that you want to receive notifications. Endpoints vary by
      #   protocol:
      #
      #   * For the `http` protocol, the endpoint is an URL beginning with
      #     \"http://\"
      #
      #   * For the `https` protocol, the endpoint is a URL beginning with
      #     \"https://\"
      #
      #   * For the `email` protocol, the endpoint is an email address
      #
      #   * For the `email-json` protocol, the endpoint is an email address
      #
      #   * For the `sms` protocol, the endpoint is a phone number of an
      #     SMS-enabled device
      #
      #   * For the `sqs` protocol, the endpoint is the ARN of an Amazon SQS
      #     queue
      #
      #   * For the `application` protocol, the endpoint is the EndpointArn of a
      #     mobile app and device.
      #
      #   * For the `lambda` protocol, the endpoint is the ARN of an AWS Lambda
      #     function.
      # @return [Subscription]
      def subscribe(options = {})
        options = options.merge(topic_arn: @arn)
        resp = @client.subscribe(options)
        Subscription.new(
          arn: resp.data.subscription_arn,
          client: @client
        )
      end

      # @!group Associations

      # @param [Hash] options ({})
      # @return [Subscription::Collection]
      def subscriptions(options = {})
        batches = Enumerator.new do |y|
          options = options.merge(topic_arn: @arn)
          resp = @client.list_subscriptions_by_topic(options)
          resp.each_page do |page|
            batch = []
            page.data.subscriptions.each do |s|
              batch << Subscription.new(
                arn: s.subscription_arn,
                client: @client
              )
            end
            y.yield(batch)
          end
        end
        Subscription::Collection.new(batches)
      end

      # @deprecated
      # @api private
      def identifiers
        { arn: @arn }
      end
      deprecated(:identifiers)

      private

      def extract_arn(args, options)
        value = args[0] || options.delete(:arn)
        case value
        when String then value
        when nil then raise ArgumentError, "missing required option :arn"
        else
          msg = "expected :arn to be a String, got #{value.class}"
          raise ArgumentError, msg
        end
      end

      class Collection

        include Aws::Resources::Collection

        # @return [Enumerator<Topic>]
        def each(&block)
          enum = super
          enum.each(&block) if block
          enum
        end

      end
    end
  end
end
