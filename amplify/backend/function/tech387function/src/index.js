//Lamba triggger to auto verify user email so they can login immediately after registration
exports.handler = (event, context, callback) => {
    // Set the user pool autoConfirmUser flag after validating the email domain
    event.response.autoConfirmUser = true;
    event.response.autoVerifyEmail = true;

    // Return to Amazon Cognito
    callback(null, event);
};
