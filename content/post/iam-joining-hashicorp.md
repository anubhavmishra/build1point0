+++
title = "I am joining HashiCorp"
description = ""
tags = [
    "Personal",
]
date = "2017-12-04"
+++

![](https://cdn-images-1.medium.com/max/1600/1*S0a_BZMhTuGoJJQ25Udrxg.png)
<span class="figcaption_hack">[Artwork by Ashley McNamara](https://github.com/ashleymcnamara/gophers)</span>

I remember the first time I used [Vagrant](https://www.vagrantup.com/)…. I ran
`vagrant up` and my developer environment was up and running in minutes!

That feeling of using a piece of software and it doing exactly want you expected
it to, does leave an impression on you. I never imagined that I would end up
working for a company that creates software that makes people smile everyday. I
am super happy to announce that I am joining HashiCorp as a Developer Advocate.
I would like to share my thoughts on the whole experience.

I have worked for [Hootsuite](https://www.hootsuite.com/) for almost four years.
Yes, that is really long time in “tech” years nowadays. Over those years I saw
the company transform from a startup to *almost* a mature enterprise. We all
know the technical and people challenges that come with such a transformation.
Interestingly enough, HashiCorp tools have helped us every step of the way. They
complimented our ideas about scaling people, process and made a huge impact in
transforming our organization. Vagrant changed the way we created and shared our
development environments. Terraform changed the way we manage infrastructure
with now 100+ developers and operators using it. I was also able to author my
first “successful” open source project called [Atlantis](https://atlantis.run/)
on top of the ideas like “Infrastructure as Code” that HashiCorp highlight in
the [Tao of HashiCorp](https://www.hashicorp.com/blog/the-tao-of-hashicorp).
Packer changed the way we [create server images across various
environments](http://code.hootsuite.com/build-test-and-automate-server-image-creation/).
We went from a process that took hours to minutes using Packer. Consul has
become the backbone of our [service discovery and feature flag
system](http://code.hootsuite.com/distributed-configuration-management-and-dark-launching-using-consul/).
I remember deploying it in production years ago when there weren’t examples of
upstart scripts or best practices about running it. I also remember emailing
[Armon Dadgar](https://medium.com/@armon), asking about best practices to
bootstrap Consul. His response couldn’t be more helpful and started a very
awesome relationship between HashiCorp and Hootsuite. This relationship grew
when our Director of Technology, [Beier Cai](https://medium.com/@beiercai),
visited HashiCorp’s San Francisco offices and somehow convinced [Mitchell
Hashimoto](https://medium.com/@mitchellh) to visit Hootsuite.

[Mitchell](https://medium.com/@mitchellh) visited Hootsuite to talk about
HashiCorp’s open source tools. Then [Armon Dadgar](https://medium.com/@armon)
followed that up couple of years later to talk about Nomad(*after I spammed him
with emails*). They didn’t need to do this… it just showed how much both
founders care about the community and the users that use their tools. This left
a lasting impression on me and I aspire to engage with community in the same
way. I was always surprised by HashiCorp’s ability to scale, both as people and
technology. They are able reach a large group of people in the community and the
enterprise space. [Seth Vargo](https://medium.com/@sethvargo) single handedly
did a lot of the developer advocacy with Armon and Mitchell sharing some of that
workload. Later, [Nic Jackson](https://medium.com/@sheriffjackson) joined them
as the first developer advocate and he continued to push the community and
products forward. It almost felt they didn’t need help doing this 😃 They were
too good! It was a bit intimidating for me back then.

**My decision**

The past few months have been stressful. And yes, you are about to hear
#firstworldproblems. I was presented with an opportunity to start a new SaaS
company with a group of awesome people. Opportunities like those were a dream of
mine when I was in school. I always imagined starting a new company that would
help push the consumer space to the next level. After a bit more of soul
searching I found that I wanted to continue the SRE / operations engineering
journey, so I interviewed with companies that I would want to be part of to help
push technology forward. The more I talked to people in these companies the more
I realized that they were experiencing problems similar to problems I had helped
resolve at Hootsuite. I wanted to progress in this space, learn new things and
help people along the way.

My role at Hootsuite has been helping developers and making them feel like
rockstars. My KPI for a long time has been making developers smile. I loved my
job. That has led me to share the cool things we did at Hootsuite with people in
the community. Talking about community; I have learned so much from people like
[Kelsey Hightower](https://medium.com/@kelseyhightower), who I am privileged
enough to call my mentor. He has taught me so many things in such a short period
of time. Being part of the Kubernetes community has been such an amazing
learning experience for me. I was able to experience how you can create a
successful open source project with the community in mind. It became pretty
clear that I wanted to talk to people and help them be awesome every step of the
way.

> There are way too many people focused on creating awesome software and only a
> few that are focused on helping those people succeed.

I wanted to be part of that group of few people and hopefully help grow the
group and help people along the way.

I went on to interview for advocate roles with a few other companies, some of
them were giant enterprises. But these conversations didn’t satisfy me. The
advocate roles weren’t really what I thought advocating should be. A Developer
Advocate enables developers to do what they really love which is to code and to
build amazing things. It’s about getting people interested and excited about
technology and what they do everyday. It’s about sharing ideas freely and your
own unique way. I didn’t feel these companies looked it that way.

I come from a family of educators. My mom and dad were both professors at
universities in India. My mom continues to lead the education movement in India.
I saw my parents educate so many people and it taught me that the reward you get
after teaching people to do a little bit better in life is priceless. This is
the core value that is engrained in me and I would be happy to carry that torch
forward in the tech community.

After creating a list of companies that aligned with my core values, HashiCorp
came out to be on the top (no surprise). So, I emailed Armon without any
expectations of getting an interview. A week or two later he replied to my email
and said that there was a head count open for a developer advocate! I then went
on to interview with HashiCorp. *The company I always looked up to*. The
interview process consisted of interviews with [Armon
Dadgar](https://medium.com/@armon) (CTO and CoFounder), Jay Fry (Head of
Marketing), [Nic Jackson](https://medium.com/@nicjackson) (Developer Advocate)
and finally [Seth Vargo](https://medium.com/@sethvargo) (Director of Technical
Advocacy). The more I talked to them, the more I felt how welcoming everyone
was. I realized that each and everyone at HashiCorp is so focused on application
delivery and meeting customers where they are. They understand both sides of the
story; **people** and **technology**. Not to mention that they do have six
successful open source projects to show for it (*Terraform, Vault, Consul,
Vagrant, Packer and Nomad)*. If you have used any one of these tools, you know
that they were built for humans. Each tool at its core follows the principles
laid out in the [Tao of
HashiCorp](https://www.hashicorp.com/blog/the-tao-of-hashicorp). My favourite
one is “Pragmatism” that aligns with my approach towards engineering and
technology.

Another important part of my life is Open Source. The way I like to look at Open
Source is that it is defined by community and the ecosystem. HashiCorp started
as an Open Source company so they understand that really well. I feel that both
of these things have made HashiCorp so successful and this makes Developer
Advocacy really important.

Now you might be thinking what went wrong at Hootsuite? The answer is
**nothing**! [Anyone reading this would be lucky to join
Hootsuite](https://hootsuite.com/about/careers). I have learnt so much from the
people there. The good thing is that I get to stay in Vancouver, BC and keep in
touch with all my friends from Hootsuite. I also organize the [HashiCorp User
Group](https://www.meetup.com/Vancouver-HashiCorp-User-Group/) in Vancouver that
calls Hootsuite one of its homes. I am excited to grow the HashiCorp community
and ecosystem in Vancouver, BC.

I am excited for my next adventure at HashiCorp where I get to collaborate with
amazing people like [Armon](https://medium.com/@armon),
[Seth](https://medium.com/@sethvargo) and
[Nic](https://medium.com/@sheriffjackson). I can’t wait to meet all you
HashiCorp users and help you in anyway I can!
