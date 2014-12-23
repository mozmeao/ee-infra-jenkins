# Jenkins-CI

This is a [ansible](http://ansible.com/) playbook to install and
configure [Jenkins-CI](http://jenkins-ci.org/) with a bunch of useful
plugins on Ubuntu 14.04

The playbook will install Nginx, configure SSL, docker, a local only
SMTP server and Jenkins plugins.


## Build your own

1. Add your certificates in `ssl/` folder. Files `ssl/ssl.key` and
   `ssl/ssl.crt` are needed. These will be copied to your server. You
   can use a self-signed certificate. Search 'generate self signed SSL
   certificate` on instructions on how to create one.

2. Copy `local_variables-dist.yml` to `local_variables.yml` and adjust
   to your preferences.

3. Add your host in `hosts`. Example `hosts`

```
[jenkins]
ci-1 ansible_ssh_host=127.0.0.1
```

4. Run the playbook:

    `ansible-playbook -i hosts site.yml`

5. Yay!


## GitHub hooks and Self-Signed Certificates

If you used a self-signed certificate in step 1, the GitHub WebHooks
set up by DotCI will not work. You need to edit the hook and disable
SSL verification.

### GitHub Webhooks

This playbook installs two GitHub plugins,
[GitHub](https://wiki.jenkins-ci.org/display/JENKINS/Github+Plugin)
and
[GitHub Pull Request Builder](https://wiki.jenkins-ci.org/display/JENKINS/Github+pull+request+builder+plugin). Read
the instructions on how to enable these. In some cases the plugins
fail to install their hooks but you can still add them manually.

For GitHub

Payload URL: https://<your_server>/github-webhook/
Content Type: x-www-form-urlencoded
Payload: Just the push event


For GitHub Pull Request Builder

Payload URL: https://<your_server>/ghprbhook/
Content Type: x-www-form-urlencoded
Payload: Pull Request and Issue Comment


