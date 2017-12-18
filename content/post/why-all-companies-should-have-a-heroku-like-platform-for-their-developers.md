+++
title = "Why all companies should have a Heroku-like platform for their developers"
description = ""
tags = [
    "Docker", 
    "Kubernetes", 
    "Paas", 
    "Deis", 
    "Helm",
]
date = "2017-08-04"
+++

# Why all companies should have a Heroku-like platform for their developers

At Hootsuite, we try to host internal hackathons pretty frequently. Like any
other hackathon, people come together, write some code and build something
awesome. But often we noticed that these hacks tend on taking longer than
expected to launch or get hosted somewhere. The need to wait for servers,
databases or domains delays launching a hack.

In this blog post we will explore how and why at Hootsuite we created a simple
PaaS on top of [Kubernetes](https://kubernetes.io/) using [Deis
Workflow](https://deis.com/docs/workflow/) and added a few kinks to make
prototyping easier for developers.

### Why should you care?

One of the biggest problems that exists today in technology companies is the
velocity to ship experiments is slow. Technology companies often don’t invest in
making prototyping easy. The reasons being the need to manage extra
infrastructure and costs. If experimental products and applications could be
created and deployed rapidly then this will encourage innovation.

Most startups today are full of entrepreneurs that want experiments to be part
of their day to day life at work. We should enable these people to get their
ideas out so we can choose the best one and run with it!

### Platform

Now I know these are a lot of platforms that allow you to host your applications
in secs and this is a solved problem.

#### Why not just use Heroku?

Certain companies create and manage their own cloud environments on AWS, Google
Cloud Platform or their own private cloud. They sometimes don’t like the idea of
using services like Heroku directly and buy into the 12 factor application model
but instead want to use the idea of something like Heroku to drive development
velocity of engineering teams. Also some companies want to do more with their
PaaS than what Heroku has to offer.

Recent movement in the cluster managers and schedulers have made application
delivery really easy and can help create platforms that help accelerate
prototyping for products and applications. The use of containers along with
cluster mangers is very powerful. After looking around in the community, few
projects that were doing something similar to what we wanted to do. These
projects are as follows:

* [Deis Workflow](http://deis.com/docs/workflow/): PaaS on top of Kubernetes that
adds a developer friendly layer to it and uses things like [Heroku
Buildpacks](https://devcenter.heroku.com/articles/buildpacks) to build
applications and deploy them on Kubernetes.
* [Empire](https://github.com/remind101/empire): PaaS on top of AWS ECS that uses
the Heroku approach as well.
* [Convox Rack](https://github.com/convox/rack): PaaS built on top of AWS uses
things like VPC, S3 and KMS etc to give you a developer friendly api.

There is a long list of projects that solve this problem. There are vast
differences in the implementation of these PaaS projects but we won’t highlight
them in this blog post.

At Hootsuite we have [Kubernetes](https://kubernetes.io/) running on AWS and we
wanted to leverage it to create our own internal PaaS that can host one time
applications in the matter of seconds. We went with [Deis
Workflow](http://deis.com/docs/workflow/) since we were already had domain
expertise in Kubernetes and to be honest it was *really* easy to setup.

### Requirements

The requirements for this platform were very simple. They were to enable
developers taking part in the hackathon to create apps with just a `git push`
and to be able to create databases for the applications with ease.

### Implementation

The implementation includes the following:

* Kubernetes cluster setup on AWS using [kops](https://github.com/kubernetes/kops)
* [Deis Workflow](http://deis.com/docs/workflow/) install using
[helm](https://github.com/kubernetes/helm)
* On demand database creation using Kubernetes
[Statefulsets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
and some go magic.

#### **Kubernetes in AWS**

First, we will start with getting a Kubernetes cluster in AWS. If you are
running on GCP, good for you. Then just “push button” deploy a cluster in GKE.

After a lot of discussions between folks in the organization (ops, security etc)
we came to a conclusion that we wanted to create a **new** AWS account to make
sure we can separate the security and stability concerns around users being able
to cause disruptions to infrastructure that powers Hootsuite’s core services.

Creating a new account in AWS and linking it to your main account is very easy.
Follow instructions [here](https://aws.amazon.com/organizations/).

We now have a brand new account that is separate from the “Production” AWS
account. The next thing we want to do is get some servers up and have Kubernetes
manage those nodes. You might have heard about “[Kubernetes the hard
way](https://github.com/kelseyhightower/kubernetes-the-hard-way/tree/818501707e418fc4d6e6aedef8395ca368e3097e)”
by [Kelsey Hightower](https://github.com/kelseyhightower). That tutorial
highlights that it is fairly complicated to get Kubernetes up and running in
AWS. You can go down this path and customize the install of Kubernetes for AWS
if you want. This is what we did for our “Production” Kubernetes cluster that
runs Hootsuite’s core services. We will blog about that some other time. But in
this case since this cluster was purely meant for prototyping we ended up using
[kops](https://github.com/kubernetes/kops). kops makes it surprising easy to get
a Kubernetes cluster up in AWS. You can use the
[tutorial](https://github.com/kubernetes/kops/blob/master/docs/aws.md) for
launching a Kubernetes cluster on AWS. After you are done you should have couple
of nodes running Kubernetes:

```bash
kubectl get nodes
NAME                            STATUS         AGE       VERSION
ip-10-0-0-1.ec2.internal        Ready          17h       v1.6.2
ip-10-0-0-2.ec2.internal        Ready,master   17h       v1.6.2
ip-10-0-0-3.ec2.internal        Ready,master   17h       v1.6.2
ip-10-0-0-4.ec2.internal        Ready,master   17h       v1.6.2
ip-10-0-0-5.ec2.internal        Ready          17h       v1.6.2
```

#### **Install Deis Workflow on top of Kubernetes**

*This is where you will realize that the Kubernetes community/ecosystem is
really strong.*

Now if we consider the datacenter as a huge computer, in our case all resources
under the AWS account would be part of our computer then that makes Kubernetes
the operating system for that computer. This is Google’s powerful “[The
Datacenter as a
Computer](http://www.morganclaypool.com/doi/abs/10.2200/S00516ED2V01Y201306CAC024)”
analogy that makes a lot of sense for systems like Kubernetes. Now you might be
wondering where I am going with this? Well we need to install things on this
huge computer. How do we do that? If you were to install lets say
[htop](http://hisham.hm/htop/) on your mac how would you do it? You can use
something like [brew](https://brew.sh/) and open your terminal and type `brew
install htop`. Now imagine if there was something like brew for Kubernetes. Well
there is..... and it is called [helm](https://github.com/kubernetes/helm) —
Kubernetes Package Manager. Helm is created by a company called
[Deis](https://deis.com/) and yes they also created Deis Workflow. Here we will
use helm to install Deis Workflow:

* Install Helm

```bash
brew install kubernetes-helm
```

* Initialize Helm and Install Tiller

```bash
helm init
```

This will install `tiller` that is the server side component for Helm that
manages and orchestrates releases in Kubernetes.

* Install Deis Workflow

```bash
helm repo add deis https://charts.deis.com/workflow
```

This will add the Deis chart repo to your helm chart repos.

```bash
helm install deis/workflow --namespace deis
```

This will install Deis Workflow. Yes! it is a single command. The helm chart for
Deis Workflow has all the necessary Kubernetes manifests that are required to
get Deis Workflow running on Kubernetes. Now follow the
[guides](https://deis.com/docs/workflow/quickstart/) on the Deis website to get
a better understanding of what is going on. Here are the few things we did to
make the Deis Workflow installation production ready:

* Make sure you don’t use the default `minio` storage option for storage. It is a
great option for testing workflow but wouldn’t recommend it for making your
cluster resilient under outages. We used `s3` storage option that can be
configured by overriding the `values.yml` file for the helm chart. Follow the
[guide](https://deis.com/docs/workflow/installing-workflow/configuring-object-storage/)
to configure object store.
* We recommend using SSL for both the Workflow API and all managed apps. Follow
the [guide](https://deis.com/docs/workflow/managing-workflow/platform-ssl/) to
enable SSL on Workflow.

Now we have Deis Workflow running on top of our Kubernetes cluster!

```bash
kubectl get pods --namespace=deis
NAME                                    READY     STATUS    RESTARTS   AGE
deis-builder-3768201740-clk0p           1/1       Running   0          38d
deis-controller-4279484688-zhxsk        1/1       Running   1          9d
deis-database-4238932065-v0rg0          1/1       Running   1          38d
deis-logger-2533678197-jd05z            1/1       Running   1          38d
...
```

Let’s now install Deis CLI:

```bash
curl -sSL http://deis.io/deis-cli/install-v2.sh | bash
sudo mv $PWD/deis /usr/local/bin/deis
```

Test Deis CLI:

```bash
deis version 
v2.15.0
```

Now just follow the
[guide](https://deis.com/docs/workflow/quickstart/deploy-an-app/) to deploy your
first app!

#### **What changes for the developer?**

So far it has been a great ride, we installed Deis Workflow that is running on
top of a production grade cluster manager(Kubernetes) on top of a decent cloud
provider(AWS). Why did we go through this process? What we want is for our
developers to love us. This is what a developer will go through if they start
using this platform:

* The traditional way:

> I finished writing my ruby app for the hackathon, I need to deploy it
> somewhere…. I guess I can talk to Ops/DevOps folks and create a JIRA ticket to
get my server and then install ruby, gem etc using ansible/chef/puppet. Then
some how put my code on to the server and then may be run a nginx reverse proxy
to expose my application. Oh wait I need a DNS entry to point to my server too!
Argghhhh its just a hackathon app!!!!

* The Deis Workflow way:

> I finished writing my ruby app for the hackthon, oh wait I see the Ops/DevOps
> folks have shared this doc with me…. something called Deis Workflow.

> (reads the document)

> Oh this is exactly like Heroku!!!! Deploying this app is going to be a piece of
> cake.

Login to Deis:

```bash
deis login 
Logged in as developer
Configuration file written to /Users/awesome-user/.deis/client.json
```

Go to the application folder that needs to be deployed:

```bash
deis create hackathon-ruby-app
Creating Application... done, created hackathon-ruby-app
Git remote deis successfully created for app hackathon-ruby-app.
```

Push to Deis remote (*the best part of this process*):

```bash
git push deis master
Counting objects: 239, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (172/172), done.
Writing objects: 100% (239/239), 375.14 KiB | 0 bytes/s, done.
Total 239 (delta 57), reused 239 (delta 57)
remote: Resolving deltas: 100% (57/57), done.
Starting build... but first, coffee!
-----> Restoring cache...
       No cache file found. If this is the first deploy, it will be created now.
-----> Ruby app detected
-----> Bootstrapping...
-----> Installing platform packages...
....
Build complete.
Launching App...
```

Open application on the browser:

```bash
deis open
```

The application will be available at:

**http://hackathon-ruby-app.awesome-platform.com**

I don’t know about you guys but we think this experience is amazing!

### OnDemand Database Creation

We now know that application deployment with Heroku like workflows is fairly
simple and fast. But what if the application needed a database? This is where
developer hacking on a project usually get stuck. If you can make database
deployment as fast as the application deployment then you have won in their
eyes. Again, we are talking about prototyping here, we don’t recommend this when
it comes to **production**.

At Hootsuite, we wanted to leverage Kubernetes [stateful
sets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) to
solve this problem. Here is how we went about it:

* Use stateful sets to bring up *HA* database installations for MySQL and Redis
* Write a simple API on top of the databases that can generate endpoints to access
the databases easily.

The stateful sets that we used are as follows:

* Redis:
[https://github.com/anubhavmishra/redis-stateful-set](https://github.com/anubhavmishra/redis-stateful-set)
and Redis Sentinel:
[https://github.com/anubhavmishra/redis-sentinel-proxy](https://github.com/anubhavmishra/redis-sentinel-proxy)
for always connecting to the master
* MySQL:
[https://github.com/kubernetes/charts/tree/master/stable/mysql](https://github.com/kubernetes/charts/tree/master/stable/mysql)

Redis:
[https://github.com/anubhavmishra/redis-stateful-set](https://github.com/anubhavmishra/redis-stateful-set)
and Redis Sentinel:
[https://github.com/anubhavmishra/redis-sentinel-proxy](https://github.com/anubhavmishra/redis-sentinel-proxy)
for always connecting to the master

So the idea being a database creation should be as simple as a `curl` call. This
will enable developers that are hacking to keep focusing on their code rather
worrying about provisioning a database. I wrote a simple golang project called
“[kuberdbs](https://github.com/anubhavmishra/kuberdbs)” to do this at Hootsuite.

### Conclusion

With the rise of cluster managers and schedulers like Kubernetes, it has become
easy and fast to experiment with ideas. This in turn drives innovation in
companies specially the ones that encourage developers or engineers to
experiment and fail. So, lets not sit back but enjoy this time that we are
living in :)

*I will be speaking at [prdcdeliver](http://www.prdcdeliver.com/) 2017 about
“How can you harness the power of entrepreneurs in your company? Give them a
PaaS!”. Hopefully share some more content after the conference.*

* [Docker](https://medium.com/tag/docker?source=post)
* [Kubernetes](https://medium.com/tag/kubernetes?source=post)
* [Paas](https://medium.com/tag/paas?source=post)
* [Deis](https://medium.com/tag/deis?source=post)
* [Helm](https://medium.com/tag/helm?source=post)
