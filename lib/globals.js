module.exports = {
    applicationPort: function(){
        //ENVIRONMENTがあるのはAWS
        if (process.env.ENVIRONMENT) {
            return 80;
        }else {
            //それ以外
            return 3000;
        }
    },
    database: function () {
        if (process.env.ENVIRONMENT) {
            var opsworks = require('./../opsworks');
            var opsWorksDB = opsworks.db;
            var rdsConnection = {
                host: opsWorksDB.host,
                port: opsWorksDB.port,
                database: opsWorksDB.database,
                user: opsWorksDB.username,
                password: opsWorksDB.password
            };
            return rdsConnection;
        } else {
            var local = require('./../config/local');
            var localConnection = local.db;
            return localConnection;
        }
    },
    awsVariables:function(){
        if(process.env.ENVIRONMENT){
            var variables = {
                bucket:process.env.S3BUCKET
            }
            console.log("variables:");
            console.log(variables);
            return variables;
        }else{
            var local=require('./../config/local');
            console.log("local.awsVariables:");
            console.log(local.awsVariables);
            return local.awsVariables;
        }
    }
}



