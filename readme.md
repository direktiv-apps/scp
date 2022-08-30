
# scp 1.0

Run scp in Direktiv

---
- #### Categories: unknown
- #### Image: direktiv.azurecr.io/functions/scp 
- #### License: [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)
- #### Issue Tracking: https://github.com/direktiv-apps/scp/issues
- #### URL: https://github.com/direktiv-apps/scp
- #### Maintainer: [direktiv.io](https://www.direktiv.io) 
---

## About scp

Run scp in Direktiv as a function

### Example(s)
  #### Function Configuration
```yaml
functions:
- id: scp
  image: direktiv.azurecr.io/functions/scp:1.0
  type: knative-workflow
```
   #### Send payload from state data.
```yaml
- id: scp
  type: action
  action:
    function: scp
    secrets:
    - SSHKEY
    input: 
      source: payload 
      target: "myuser@192.168.1.10:/home/myuser/Downloads/payload" 
      identity: 
        name: id
        data: 'jq(.secrets.SSHKEY)'
        mode: "0600"
      payload:
        name: payload
        data: 'Hello, world!\n'
      recursive: false
      verbose: false
```
   #### Send payload from variable file.
```yaml
- id: scp
  type: action
  action:
    function: scp
    secrets:
    - SSHKEY
    files: 
    - key: payload
      scope: namespace
      as: payload
    input: 
      source: payload 
      target: "myuser@192.168.1.10:/home/myuser/Downloads/payload" 
      identity: 
        name: id
        data: 'jq(.secrets.SSHKEY)'
        mode: "0600"
      recursive: false
      verbose: false
```
   #### Get data from remote host and store in a variable file.
```yaml
- id: scp
  type: action
  action:
    function: scp
    secrets:
    - SSHKEY
    input: 
      source: "myuser@192.168.1.10:/home/myuser/Downloads/payload" 
      target: payload
      identity: 
        name: id
        data: 'jq(.secrets.SSHKEY)'
        mode: "0600"
      recursive: false
      verbose: false 
```
   #### Move data between two remote hosts.
```yaml
- id: scp
  type: action
  action:
    function: scp
    secrets:
    - SSHKEY
    input: 
      source: "myuser@192.168.1.10:/home/myuser/Downloads/payload" 
      target: "myuser@192.168.1.11:/home/myuser/Downloads/payload" 
      identity: 
        name: id
        data: 'jq(.secrets.SSHKEY)'
        mode: "0600"
      recursive: false
      verbose: false      
```

   ### Secrets


- **sshkey**: Plain string of an ssh key with permission to access remote hosts.






### Request



#### Request Attributes
[PostParamsBody](#post-params-body)

### Response
  List of executed commands.
#### Reponse Types
    
  

[PostOKBody](#post-o-k-body)
#### Example Reponses
    
```json
{
  "success": true
}
```

### Errors
| Type | Description
|------|---------|
| io.direktiv.command.error | Command execution failed |
| io.direktiv.output.error | Template error for output generation of the service |
| io.direktiv.ri.error | Can not create information object from request |


### Types
#### <span id="post-o-k-body"></span> postOKBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| scp | [PostOKBodyScp](#post-o-k-body-scp)| `PostOKBodyScp` |  | |  |  |


#### <span id="post-o-k-body-scp"></span> postOKBodyScp

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| success | boolean| `bool` | ✓ | |  |  |


#### <span id="post-params-body"></span> postParamsBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| identity | [DirektivFile](#direktiv-file)| `apps.DirektivFile` | ✓ | |  |  |
| payload | [DirektivFile](#direktiv-file)| `apps.DirektivFile` |  | |  |  |
| recursive | boolean| `bool` |  | |  |  |
| source | string| `string` | ✓ | |  |  |
| target | string| `string` | ✓ | |  |  |
| verbose | boolean| `bool` |  | |  |  |

 
