# cyberchef-docker
This builds a container with [CyberChef](https://github.com/gchq/CyberChef). Nginx serves the page on an alpine container. This greatly simplifies whatever I was doing previously trying to build it on each container build, now I just use their release instead of trying to build from source. 

I used the approach [here](https://starkandwayne.com/blog/how-to-download-the-latest-release-from-github/) because it let me build the container with the latest version of CyberChef without having to include any of the bits in the repo. 

```
wget --quiet $(curl -s https://api.github.com/repos/gchq/CyberChef/releases/latest | jq -r ".assets[] | select(.name) | .browser_download_url" | grep zip) -O /tmp/chef.zip
```
