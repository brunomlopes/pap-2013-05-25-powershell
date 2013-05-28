var settings = require('./settings'),
	azure = require('azure');

var serviceBusService = azure.createServiceBusService(settings.namespace, settings.key);
var topic = 'TestTopic';
var subscriptionName = 'AllMessages';

var receive_message = function(error, receivedMessage) {
	if (!error) {
		// Message received and deleted
		console.log("-- Here's a message: ");
		console.log(receivedMessage);
	} else {
		if (error != 'No messages to receive') {
			console.error("error receiving messages");
			console.log(error);
		}
	}
	
	serviceBusService.receiveSubscriptionMessage(topic, subscriptionName, {
		timeoutIntervalInS: 60 * 60
	}, receive_message);
};

function send_and_receive_messages(serviceBusService) {
	var message = {
		body: 'Test message',
		customProperties: {
			messagenumber: 0
		}
	}
	
	message.body = '';
	serviceBusService.sendTopicMessage(topic, message, function(error) {
		if (error) {
			console.log("error sending message " + message.body + ":");
			console.log(error);
		}
	});
	console.log("Waiting for messages");
	serviceBusService.receiveSubscriptionMessage(topic, subscriptionName, receive_message);
}

function create_subscription(serviceBusService) {
	serviceBusService.createSubscription(topic, subscriptionName, function(error) {
		if (!error) {

		} else {
			console.log("Error creating subscription");
			console.log(error);
		}
	});
}

serviceBusService.createTopicIfNotExists(topic, function(error) {
	if (!error) {
		// Topic was created or exists
		send_and_receive_messages(serviceBusService);
	} else {
		console.log("Error creating topic: ");
		console.log(error);
	}
});

var keepGoing = true;

var stdin = process.openStdin();
stdin.on('data', function(chunk) {
	var data = chunk.toString();
	if (data[0] == 'q') {
		console.log("Exiting");
		process.exit();
	}
});