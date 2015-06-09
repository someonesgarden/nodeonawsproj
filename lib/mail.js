var aws = require('aws-sdk');
var globals = require('./globals');

function sendEmail(params, callback) {
    if (globals.awsVariables().key) {
        aws.config.update({
            accessKeyId: globals.awsVariables().key,
            secretAccessKey: globals.awsVariables().secret
        });
    }

    console.log("params");
    console.log(params);

    var ses = new aws.SES({region: 'us-west-2'});
    var recipient = params.username + '<' + unescape(params.email) + '>';
    var sesParams = {
        Source: params.messageSource,
        Destination: {
            ToAddresses: [recipient],
            BccAddresses: params.bccAddress
        },
        Message: {
            Subject: {
                Data: params.subject,
                Charset: 'UTF-8'
            },
            Body: {
                Text: {
                    Data: params.messageText,
                    Charset: 'UTF-8'
                },
                Html: {
                    Data: params.messageHTML,
                    Charset: 'UTF-8'
                }
            }
        },
        ReplyToAddresses: [emailSender()]
    }
    ses.sendEmail(sesParams, function (err, data) {
        callback(err, data);
    });
}

function sendRegistrationConfirmation(params, callback) {
    var emailParams = {
        username: params.username,
        email: params.email
    };
    console.log("params.email");
    console.log("email:"+params.email);
    emailParams.messageSource = emailSender();
    emailParams.bccAddress = [];
    emailParams.subject = 'Registration Confirmation';
    emailParams.messageText = 'You have successfully registered for Photoalbums. Your username is' + emailParams.username + '.';
    emailParams.messageHTML = 'You have successfully registered for Photoalbums. Your username is<strong>' + emailParams.username + '</strong>.';
    sendEmail(emailParams,callback);
}

function emailSender(){
    console.log('d@'+globals.rootDomain());
    return 'd@'+globals.rootDomain();
}

exports.sendRegistrationConfirmation = sendRegistrationConfirmation;