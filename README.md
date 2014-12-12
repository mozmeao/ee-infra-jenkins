# Jenkins-CI with DotCI

This is a [ansible](http://ansible.com/) playbook to install and
configure [Jenkins-CI](http://jenkins-ci.org/) and
[DotCI](https://github.com/groupon/DotCi) on Ubuntu 14.04.

The playbook will install Nginx, configure SSL, mongodb (required by
DotCI), docker and DotCI.


## Build your own

1. Add your certificates in `ssl/` folder. Files `ssl/ssl.key` and
   `ssl/ssl.crt` are needed. These will be copied to your server. You
   can use a self-signed certificate. Search 'generate self signed SSL
   certificate` on instructions on how to create one.

2. Create a
   [GitHub Application](https://github.com/settings/applications/new)
   for your JenkinsCI. This is needed by DotCI. Set `Authorization
   callback URL` to `https://<ip>/dotci/finishLogin`.

3. Populate `github_client_id` and `github_secret` in
`local_variables.yml` using the values supplied by GitHub in
step 2. You also want to create a first Jenkins user. Populate
`jenkins_user` and `jenkins_password` variables in
`local_variables.yml`.


4. Add your host in `hosts`. Example `hosts`

```
[jenkins]
ci-1 ansible_ssh_host=127.0.0.1
```

5. Run the playbook:

    `ansible-playbook -i hosts site.yml`

6. Login in your new Jenkins install and configure DotCI jobs. Note
   that DotCI jobs must be generated using the "New DotCI Job" link
   and not the "New Job" link. Read DotCI documentation for more.


## GitHub hooks and Self-Signed Certificates

If you used a self-signed certificate in step 1, the GitHub WebHooks
set up by DotCI will not work. You need to edit the hook and disable
SSL verification.

