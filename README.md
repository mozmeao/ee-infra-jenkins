# Jenkins-CI

This is an [ansible](http://ansible.com/) playbook to install and
configure [Jenkins-CI](http://jenkins-ci.org/).

The playbook will install NGINX, configure SSL, Docker, a local-only
SMTP server and Jenkins. It will also install Docker-maintenance cron
jobs and Jenkins-backup scripts to S3.

Used in combination with [Deis](https://deis.io) for Docker-based
Continuous Delivery of Websites. See also
[webprod-deis](http://www.github.com/mozilla/webprod-deis).

## Build your own

1. Add your SSL certificates in `ssl/` folder. Files `ssl/ssl.key` and
   `ssl/ssl.crt` are needed. These will be copied to your server. You
   can use a self-signed certificate. Search 'generate self signed SSL
   certificate` on instructions on how to create one.

3. Copy `local_variables-dist.yml` to `local_variables.yml` and adjust
   to your preferences.

4. Add your host in `hosts`. Example `hosts`

```
[jenkins]
127.0.0.1
```

5. Run the playbook:

    `ansible-playbook -i hosts site.yml`

6. Yay!


### GitHub Webhooks

This playbook installs two GitHub plugins,
[GitHub](https://wiki.jenkins-ci.org/display/JENKINS/Github+Plugin)
and
[GitHub Pull Request Builder](https://wiki.jenkins-ci.org/display/JENKINS/Github+pull+request+builder+plugin). Read
the instructions on how to enable these. In some cases, the plugins
fail to install their hooks, but you can still add them manually.

For GitHub

* Payload URL: `https://<your_server>/github-webhook/`
* Content Type: `x-www-form-urlencoded`
* Payload: `Just the push event`


For GitHub Pull Request Builder

* Payload URL: `https://<your_server>/ghprbhook/`
* Content Type: `x-www-form-urlencoded`
* Payload: `Pull Request and Issue Comment`


## Jenkins backups

This playbook expects that you use the [ThinBackup](https://wiki.jenkins-ci.org/display/JENKINS/thinBackup) Jenkins plugin and that you save backups in `/var/lib/jenkins/backups`.

## Disaster recovery

In case of a disaster follow these steps:

1. Create a new server based on Ubuntu 14.04.
2. Run this playbook against the server created in step 1.
3. Copy the ThinBackup backups from S3 to the new server under `/var/lib/jenkins/backups`.
4. Go to your new Jenkins management interface -> Plugins -> Install ThinBackup. Restart Jenkins.
5. Configure ThinBackup to store backups in `/var/lib/jenkins/backups`. Restart Jenkins.
6. ThinBackup Restore should list all your backups. Restore the latest. This should restore all Jenkins jobs and all configurations.
7. Run jobs to verify that everything is OK. Drink relaxing tea, you earned it.

Note that environment passwords used in jobs will not be restored and you will have to do this manually.
