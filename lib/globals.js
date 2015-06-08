module.exports = {
    applicationPort: function(){
        if (process.env.ENVIRONMENT) {
            return 80;  //ENVIRONMENTがあるのはAWS
        }else {
            return 3000;//それ以外
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
                bucket:process.env.S3BUCKET,
                domain:process.env.DOMAIN
            }
            return variables;
        }else{
            var local=require('./../config/local');
            return local.awsVariables;
        }
    },
    absoluteURL:function(path){
        if(this.awsVariables().domain){
            return this.awsVariables().domain+"/"+path;
        }
        return path;
    },
    rootDomain:function(){
        return this.awsVariables().domain.replace('http://www.','');
    }
}



