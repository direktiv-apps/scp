
# scp 1.0

Secure copy between hosts

---
- #### Categories: network
- #### Image: gcr.io/direktiv/functions/scp 
- #### License: [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0)
- #### Issue Tracking: https://github.com/direktiv-apps/scp/issues
- #### URL: https://github.com/direktiv-apps/scp
- #### Maintainer: [direktiv.io](https://www.direktiv.io) 
---

## About scp

This function enables to secure copy (SCP) between Direktiv and remote hosts or between two remote hosts. It is recommended to use SSH keys for authentication but  password authentication is supported for the source host.
If SCP is required between two remote hosts with password two SCP steps need to be executed. The first step copies the file to Direktiv and the second command copies it  remotely. 
Additionally the files can be stroed in Direktiv's `out` folders to store them for later use, e.g. `out/workflow/myfile` would store the file in Direktiv's workflow scope. 

### Example(s)
  #### Function Configuration
```yaml
functions:
- id: scp
  image: gcr.io/direktiv/functions/scp:1.0
  type: knative-workflow
```
   #### SCP local to remote with certificate
```yaml
- id: scp1 
  type: action
  action:
    secrets: ["sshkey"]
    files: 
    - key: payload.txt
      scope: workflow
    function: scp
    input: 
      scp:
      - source:
          file: payload.txt
        target:
          host: ec2-11-111-99-99.compute-1.amazonaws.com
          user: ubuntu
          identity: jq(.secrets.sshkey)
          file: /tmp/myfile
  catch:
  - error: "io.direktiv.command.error"
```
   #### SCP remote to remote with certificate
```yaml
- id: scp2 
  type: action
  action:
    secrets: ["sshkey"]
    function: scp
    input: 
      scp:
      - source:
          host: ec2-11-111-99-99.compute-1.amazonaws.com
          user: ubuntu
          identity: jq(.secrets.sshkey)
          file: /tmp/hello1
        target:
          host: ec2-11-111-99-100.compute-1.amazonaws.com
          user: ubuntu
          identity: jq(.secrets.sshkey)
          file: /tmp/myfile
  catch:
  - error: "io.direktiv.command.error"
```
   #### Copy with password between remotes with ssh key and password
```yaml
- id: getter 
  type: action
  action:
    secrets: ["sshkey", "scppwd"]
    function: scp
    input: 
      scp:
      - source:
          host: ec2-11-111-99-99.compute-1.amazonaws.com
          user: ubuntu
          identity: jq(.secrets.sshkey)
          file: /tmp/hello1
        target:
          file: file1
      - source:
          file: file1
        target:
          host: 192.168.1.1
          user: direktiv
          password: jq(.secrets.scppwd)
          file: /tmp/targetfile
  catch:
  - error: "io.direktiv.command.error"
```
   #### Copy from remote to Direktiv variable
```yaml
- id: getter 
  type: action
  action:
    secrets: ["scpkey", "scppwd"]
    function: scp
    input: 
      scp:
      - source:
          host: 10.100.6.8
          user: direktiv
          password: jq(.secrets.scppwd)
          file: /tmp/file
        target:
          file: out/workflow/myfile.txt
  catch:
  - error: "io.direktiv.command.error"
```

   ### Secrets


- **sshkey**: SSH key for target or source. Each remote can have a key.
- **scppwd**: Passwords are only allowed for the source of the involved hosts.






### Request



#### Request Attributes
[PostParamsBody](#post-params-body)

### Response
  List of executed scp commands.
#### Reponse Types
    
  

[PostOKBody](#post-o-k-body)
#### Example Reponses
    
```json
[
  {
    "result": "copying from a to b",
    "success": true
  }
]
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
| scp | [][PostOKBodyScpItems](#post-o-k-body-scp-items)| `[]*PostOKBodyScpItems` |  | |  |  |


#### <span id="post-o-k-body-scp-items"></span> postOKBodyScpItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| result | [interface{}](#interface)| `interface{}` | ✓ | |  |  |
| success | boolean| `bool` | ✓ | |  |  |


#### <span id="post-params-body"></span> postParamsBody

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| scp | [][PostParamsBodyScpItems](#post-params-body-scp-items)| `[]*PostParamsBodyScpItems` |  | |  |  |


#### <span id="post-params-body-scp-items"></span> postParamsBodyScpItems

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| recursive | boolean| `bool` |  | | Copy recursivley, e.g folders |  |
| source | [ScpPart](#scp-part)| `ScpPart` | ✓ | |  |  |
| target | [ScpPart](#scp-part)| `ScpPart` | ✓ | |  |  |
| verbose | boolean| `bool` |  | | Show verbose output |  |


#### <span id="scp-part"></span> scpPart

  



**Properties**

| Name | Type | Go type | Required | Default | Description | Example |
|------|------|---------|:--------:| ------- |-------------|---------|
| file | string| `string` | ✓ | | File to copy. In target the Direktiv `out` folders can be used, e.g. `out/workflow/myfile` to store the file in workflow scope. |  |
| host | string| `string` |  | | Hostname of the target or source. Empty if local. |  |
| identity | string| `string` |  | | SSH key for the target or source. |  |
| password | string| `string` |  | | Password for target or source. Only the source host can use a password. SSH key recommended. |  |
| port | integer| `int64` |  | `22`| Port of the target or source. Empty if local. |  |
| user | string| `string` |  | | User of the target or source. |  |

 
