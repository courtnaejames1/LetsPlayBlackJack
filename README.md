# Overview

The project uses Ruby on Rails to create a web applications to play Black Jack. 
Players are allowed to create games setting with starting bets and also personalizing 
the name of their game. 

Once a game is created, a game entry is made and holds the details of the game for the specific user.  

There aren't many things implemented for the game as yet. However, some of the features I want to implement are:

- When the game is finished the play will be allowed to view a list of games they played showing if they won or not. 

- This game will also have functionality for multiplier games


# Set Up Process 

**Install Ruby preferably 3.2 or newer**

**Linux**  
``` bash
# Install dependencies with apt
$ sudo apt update
$ sudo apt install build-essential rustc libssl-dev libyaml-dev zlib1g-dev libgmp-dev git

# Install Mise version manager
$ curl https://mise.run | sh
$ echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.bashrc
$ source ~/.bashrc

# Install Ruby globally with Mise
$ mise use -g ruby@3
```

**Windows OS**
1. First download Windows Subsystem Linux
```bash
$ wsl --install --distribution Ubuntu-24.04
```
2. Then run the following commands 

```bash
# Install dependencies with apt
$ sudo apt update
$ sudo apt install build-essential rustc libssl-dev libyaml-dev zlib1g-dev libgmp-dev

# Install Mise version manager
$ curl https://mise.run | sh
$ echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
$ source ~/.bashrc

# Install Ruby globally with Mise
$ mise use -g ruby@3
```

**Install Rails preferably 8.1.0 or newer**

```bash
$ gem install rails
```

# Database creation 

- To set up the database, in the terminal run `bin/rails db:migrate`

# How to run the website 
- In the terminal run `bin/rails server `


# Tech details of this project

* Ruby version
    - 3.4.10 
* Rails Version
    - 8.1.3.1




