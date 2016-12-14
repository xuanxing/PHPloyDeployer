#PHPloyDeployer

`v1.1.0`

### Prepare
* `cd` to your project directory
* make sure git repository existed in your project directory
* add followings to your `.gitignore`
```
/PHPloyDeployer/
/phploy*
```

### install
```
# git clone https://github.com/xuanxing/PHPloyDeployer.git
```

### help!
```
# PHPloyDeployer/says -h
```

### steps
* check available servers
* add servers to registry
* set working directory
* build phploy

### example
```
# PHPloyDeployer/says -h
# PHPloyDeployer/says -s -a test -r
# PHPloyDeployer/says -w /path/to/your/project/ -erb
```

### deploy
```
# php phploy -l
# php phploy [-s <server_name>]
```
see https://github.com/banago/PHPloy

### config your server 
```
[example]
scheme = ftp
user = ftp_user
pass = ftp_user_password
host = target_host
path = /path/to/your/public/directory
port = 21
branch = target_git_branch
permissions = 0774
directoryPerm = 0755
;; files that included by git but excluded by phploy
exclude[] = "PHPloyDeployer/*"
exclude[] = "phploy*"
;; files that excluded by git but included by phploy
;include[] = ""
;; folders to be purged before deployment
;purge[] = ""
;; shell commands to run before deployment
;pre-deploy[] = ""
;; shell commands to run after deployment
;post-deploy[] = ""
;; shell commands to run on remote server before deployment, require SSH2 connection
;pre-deploy-remote[] = ""
;; shell commands to run on remote server after deployment, require SSH2 connection
;post-deploy-remote[] = ""
logger = on
```