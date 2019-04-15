---
title: Wait, what? Getting your bearings with ServerSpec
template: ./reveal.html
theme: ./hardy.css
highlight-theme: atom-one-dark
revealOptions:
    transition: 'none'
    slideNumber: 'c/t'

---

# Wait, what?

### Getting your bearings with ServerSpec

*Hardy Pottinger*

Digital Library Software Developer, UCLA Library

@hardy.pottinger

hpottinger@library.ucla.edu

![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/80x15.png)

_This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/)</a>._

Note:
Hi, I'm Hardy Pottinger, I work for UCLA Library as a software developer, this
workshop is all about ServerSpec.

---
# Agenda

* 30 minutes: introduction to ServerSpec
* 3 hours: 3 scenarios (with a break or two)
* 30 minutes: questions and wrap-up

Note:
So, here's the rough outline of our plan for today: we'll start off with a quick
intro to ServerSpec, then we'll dive into three scenarios which will challenge
you to write some ServerSpec tests under hopefully realistic circumstances.
Don't let the pace of this intro frighten you off, I delivered these slides as
a lightning talk at Code4Lib back in March, we have time to dive in, this is
just the intro.

But, before we even talk about what ServerSpec is, let's set the stage.

After working in library tech a while, here's a thing I know...

---
# We are constantly learning about our environment
* Developers shop jobs a lot
* Have you seen the mailing list?
* We change jobs a lot
* Our jobs change a lot all on their own
* `We are always the newbie`

Note:
We are constantly learning. Heh, mailing list. And our jobs change all the time. We are always the newbie.

----
<!-- .slide: data-background="./images/_absolutely_free_photos_original_photos_connection-of-ideas-3600x2542_26127.jpg" data-background-size="contain"-->
# always the newbie <!-- .element: class="fragment" -->
Note:
Here's a story I read a while back. First day, new job, your trainer has been giving you notes all day, and then they go, “Ok, lets walk through each machine. There are 10 web servers, 9 of them are called dub-something, and one is called bubbles.” You quickly grab a piece of paper, “Bubbles?”, “Yep the admin before you didn’t like standard names, wanted to give machines ‘personality’, so we have that one off.” Sound familiar? Here's something you can do to make sense of all that stuff.



---
# Why write tests?
## With ServerSpec or any similar tool?
* Tests are documentation
* Your team may not survive
* Tools come and go
* No matter what happens to the tools or your team, tests will persist as documentation of your intentions and proof that the service is configured as you expected

Note:
How can tests possibly help? And why ServerSpec?
Well, honestly, it's one option, and I'll get into *why* at the end. Right now,
let's leave it at: Tests are documentation. Your team may not survive. Tools
come and go. But if you write tests in ServerSpec, your tests will
remain accessible to anyone reading the code. I'll show you.

---
# ServerSpec
* Extension of RSpec
* Is a Ruby gem

Note:
ServerSpec is an extension of RSpec, which is a testing framework
for Ruby. Before we get too much further...

---
# Software Reuse
## spec spec spec...
* RSpec
* ServerSpec
* DockerSpec
* SpecInfra  ¯\\_(ツ)_/¯
Note:
...you'll hear me mention a few different words with "spec" in them. There will
be a diagram, but it's too much detail right now. This is normal Ruby stuff.
Software reuse.

---
# Installing ServerSpec
* It's a Ruby gem, you'll need Ruby 2.0.x+ installed
`sudo gem install serverspec`
* Rake, too:
`sudo gem install rake`
* SSH access to the servers you are testing
* Sudo not required, but it makes life easier

Note:
Yep, it's Ruby, and you'll need Rake. Sudo helps, but it's not required.

It does have an init command, which can get you started.

---
```
$ serverspec-init
Select OS type:
  1) UN*X
  2) Windows
Select number: 1
Select a backend type:
  1) SSH
  2) Exec (local)
Select number: 1
Vagrant instance y/n: n
Input target host name: waitwat
 + spec/
 + spec/waitwat/
 + spec/waitwat/sample_spec.rb
 + spec/spec_helper.rb
 + Rakefile
 + .rspec
```
`serverspec-init` <!-- .element: class="fragment" data-code-focus="1" -->
`, answers` <!-- .element: class="fragment" data-code-focus="5,9,10,11" -->
`, boom` <!-- .element: class="fragment" data-code-focus="12-17" -->
`, sample_spec.rb` <!-- .element: class="fragment" data-code-focus="14" -->


Note:
So, you type in serverspec-init and answer a few questions, pick your OS, select
a backend type, blah blah bla. And boom, you get a nice set of files, a basic
starter kit. Let's look at the sample_spec file.

---
```
require 'spec_helper'
describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe file(/etc/httpd/conf/httpd.conf) do
  it {should be_file}
  it {should contain "ServerName my-server-name"}
end
```
`spec_helper`<!-- .element: class="fragment" data-code-focus="1" -->
`, package resource`<!-- .element: class="fragment" data-code-focus="2-4" -->
`, service resource`<!-- .element: class="fragment" data-code-focus="6-9" -->
`, port resource`<!-- .element: class="fragment" data-code-focus="11-13" -->
`, file resource`<!-- .element: class="fragment" data-code-focus="15-18" -->

Note:
You've seen Rails, you've seen a "helper", it's a way to pull out some
complexity to improve the readability of your code. For ServerSpec, it helps
improve the readability of your tests. Skip it for now, instead, let's look at
all the other pieces we get. Each of these other sections are what are called
Resources. In the sample, we have a package resource, a service resource, a
port resource and a file resource. And the tests are pretty clear about what
they expect, right? It should be a file, it should contain something.
---
# Resources
https://serverspec.org/resource_types.html
* packages
* services
* ports
* files
* commands
* users and groups
* cron

Note:
Of course there are many more resources. Every time I look at this page I notice
something I've never used before, or want to try again.

OK, so, that's what the tests look like, what about running them?
---
# Run the tests
* RSpec tests usually go in a folder called `spec`
* calling ServerSpec is exactly the same as any other RSpec test

`rspec spec`

* this will run all the tests in the spec folder
* or `spec/ask/for/whichever/spec.rb` you want
* you can also use a Rakefile to automate more complex tests

Note:
Normal RSpec practice puts the tests in a spec folder. You run them with the
rspec command. Give it a path to a specific file, just that file will be run.
Or a folder, all the tests in the folder will run. Or you can get fancy with a
Rakefile. Here, I'll show you a demo.
---
## Demo: 1 ServerSpec-Samvera
* [code: tinyurl.com/uclalibrary-serverspec-samvera](https://tinyurl.com/uclalibrary-serverspec-samvera)
* [demo](https://asciinema.org/a/LrkbHUBGBsd0NuR3ZVPkc6bC3)
<asciinema-player src="sessions/serverspec_samvera_demo.cast" speed="2" cols="100" rows="20" font-size="16px" theme="monokai" tabindex="1" id="demo1" />
---
# Scaling up to more than one server
https://tinyurl.com/uclalibrary-serverspec-samvera

Note:
Here's a link to the tests that I just ran in that demo. I used a Spec_helper
to add the ability to include shared libraries of test code. But let's just peek
at the code.

---
# Spec_helper
```
require 'serverspec'
require 'pathname'
require 'net/ssh'
require 'yaml'

base_spec_dir = Pathname.new(File.join(File.dirname(__FILE__)))

Dir[base_spec_dir.join('shared/**/*.rb')].sort.each{ |f| require f }

set :backend, :ssh
set :disable_sudo, true

set :path, '/usr/sbin:$PATH'

properties = YAML.load_file(base_spec_dir.join('properties.yml'))

options = Net::SSH::Config.for(host)
options[:user] = 'deploy'
host = ENV['TARGET_HOST']

set :host,        options[:host_name] || host
set :ssh_options, options

set_property properties[host]
```
Note:
The spec_helper file is a way to pull out some complexity to improve the
readability of your code. For ServerSpec, it helps improve the readability of
your tests. I'll skip the details, there are links in the slides. The other
piece of this is a Rakefile.

---
# Use a Rakefile
* automate the running of complex tests
* Rake is a software task management and build automation tool
* Similar to Make
* Written in Ruby

Note:
You know, it's kinda like Make, it lets you put together smaller pieces
into a whole.

---
# Sharing code
https://serverspec.org/advanced_tips.html
https://tinyurl.com/uclalibrary-serverspec-samvera

Note:
Here's the code for that demo. And a link to the documentation that inspired it.
I promised a diagram of all this stuff, here's one I found.

---
<!-- .slide: data-background="./images/serverspec_components.jpg" data-background-size="contain"-->

Note:
It's all an extension of RSpec. ServerSpec sits on top of another gem called
SpecInfra. SpecInfra handles all the specific calls to whatever kind of thing
you are testing. This is important if you find a bug.

---
# Gotchas
* you'll need to be sure the `ss` command is available on the test target
  * this is installed by default on RHEL
  * for Ubuntu, you'll need to install the `iproute2` package
* you'll need to be sure `/usr/sbin` is in the path, if your test target is RHEL
  * you can set the `:path` in spec_helper

Note:
Some gotchas I know about. You'll need the ss command, it's like netstat but not
deprecated. It's included on Redhat, you'll need to install iproute2 on Ubuntu.
And sbin needs to be in your path, Ubuntu does that, but RH doesn't. You can set
the path in the spec_helper. The big one is that most of these tools
are run by a single developer. And he has issues turned off in GitHub. So, it'll
be up to you to at least suggest a fix for any bug you find, and make a pull
request.

---
# Containers? Docker?
* many options are available, worth researching
* DockerSpec: https://github.com/zuazo/dockerspec

Note:
What about containers? Docker? There are options, and fun reading. I recommend
DockerSpec, here, let me show you a demo.

---
## Demo: 2 Docker-Cantaloupe
* [code: github.com/UCLALibrary/docker-cantaloupe](https://github.com/UCLALibrary/docker-cantaloupe)
* [demo](https://asciinema.org/a/0lKzSKyfu9CJpoAa2Nq1CZkIZ)
<asciinema-player src="sessions/docker-cantaloupe-demo.cast" speed="2" cols="100" rows="20" font-size="16px" theme="monokai" tabindex="1" id="demo2" />
----
# Other options
* [InSpec](https://github.com/chef/inspec) (still Ruby, by the Chef people)
* [Goss](https://github.com/aelsabbahy/goss) (YAML, can generate tests from current system state)
* [TestInfra](https://github.com/philpep/testinfra) (Python, works well with Ansible)
* [Molecule](https://github.com/ansible/molecule) (only tests Ansible roles)

Note:
There are other options, of course, Inspec is still Ruby and the syntax is very similar (it's also based on RSpec), Goss can generate tests based on the current system state and is a great option if you're
in a hurry. Testinfra is a great fit for an Ansible shop. Molecule is for Ansible Roles, so it might be enough.
----
# Why ServerSpec?
https://medium.com/@Joachim8675309/serverspec-vs-inspec-17272df2718f
- ServerSpec is targeted for the developer working on DevOps
- integrates with Vagrant and Docker
- gains a lot of fexibility from leveraging RSpec
- works well with SSH, so moving from local tests to infrastructure tests is straightforward

Note:
So, why would you pick ServerSpec over all these other options, especially since
it is run by a single developer? I suppose it depends on your use case. If you're
looking for a tool that can transition from local devops work to testing deployments
to staging or prod, ServerSpec is a great fit. If you want to write tests that can
survive a long time and still be clear about what they expect, ServerSpec is the tool
you should use. If you aren't doing this kind of testing, it's a good starting point.
---
# Three Scenarios... getting ready
* you do not have to follow along on your computer, you can just watch me
* slides are at: [github.com/hardyoyo/ucdlfx19-serverspec-workshop](https://github.com/hardyoyo/ucdlfx19-serverspec-workshop)
* if you do want to follow along, you need Ruby 2.5.1 or higher installed
* to install ServerSpec, run this: `gem install serverspec`
---
# Three Scenarios: disclaimer
The story, all names, characters, and incidents portrayed in this workshop are
fictitious. No identification with actual persons (living or deceased), places,
buildings, and products is intended or should be inferred.

---
# Three Scenarios... the premis
* you are the newbie, a new hire, at a fictitious academic library
* you are trying to make sense of it all
* you want to be useful at the same time
* this place is a mess

---
# Scenario One: Most of our stuff is static? We think?
* write a test to confirm Apache is running and it's the correct version
* deal with any surprises that come up

---
# Scenario Two: We really want to move everything to Samvera
* "We have a pilot server"
* write a test for this pilot server

---
# Scenario Three: Gosh, everything on the same box is slow, let's split it out
* refactor the test for the pilot server into pieces that can be reused
* write a test for each environment (dev, staging, prod) using these pieces

---
# Questions and Wrap-up


---
# Thanks
* Inspiration for this workshop: JJ Asghar's /Rants and Ramblings blog post on ServerSpec:
https://jjasghar.github.io/blog/2013/07/12/serverspec-the-new-best-way-to-learn-and-audit-your-infrastructure/
* _ServerSpec Components_, adapted from ["Introduction to Test-Driven Docker Development,"](https://entwickler.de/online/development/docker-test-driven-development-b-170207.html) by Peter Roßbach,  Wednesday, August 12, 2015, [Entwickler.de](https://entwickler.de/)

Slides:
[github.com/hardyoyo/ucdlfx19-serverspec-workshop](https://github.com/hardyoyo/ucdlfx19-serverspec-workshop)

Note:
Credits, links in the slides. Thanks!