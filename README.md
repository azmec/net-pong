Status: In Development
Current Version: 0.0.7 

# TODO
- [x] 0.1.0: Bare Minimum of Pong.
- [ ] 0.1.5: Sounds
- [ ] 0.2.0: Functional Main Menu.
- [ ] 0.3.0: AI Update.
- [ ] 0.4.0: Online Multiplayer.
- [ ] 0.5.0: Game Juice.
- [ ] 0.6.0: Configurable Settings to Your Heart's Content.
- [ ] 1.0.0: Playtested; released.

# Net Pong :space_invader:
Net Pong is a an exploration into the LOVE2D networking module. It's simply multiplayer pong, provided you're capable of port-fowarding.

## What's in Here
You'll notice a /love-project and /masterplan in this repository. The former is the true source code, but the latter is a project for MasterPlan if that interests you, which you can find more about [here](https://solarlune.itch.io/masterplan)

## How to Play :video_game:
### Installation
You can choose to either download the provided binaries, avaliable for Windows and Linux, or download this repo and use the LOVE2D framework itself.

If you're using the LOVE2D framework itself, just find your love executable and drag the love-project folder onto it. 

Launching the game will provide you with a menu that lists singleplayer, multiplayer, and settings. Pressing singleplayer will pit you against a bot for a high-score.

### Multiplayer
Yet to be done! See TODO.

## How to Mess With It :wrench:
If you're in the pursuit of learning LOVE2D networking or new to the framework in general, this project should be useful. It's barebones enough that you can dissect it in a day, and I've worked to document the contents of the project (for my sake and yours.)

You can start with the settings.lua file and figure how those parameters affect the game. From there, you should work to understand the core loop of the game, found in main.lua.

If you're new to LOVE2D or Lua in general, here are some resources to start you out:
- [Getting Started with LOVE2D](https://love2d.org/wiki/Getting_Started)
- [The LOVE Module in General](https://love2d.org/wiki/love)
- [Lua Reference Manual](https://www.lua.org/manual/5.4/)
- [Programming in Lua (first edition)](https://www.lua.org/pil/contents.html)

Of course, the best way to learn is to experiment on your own!

## Credits :page_with_curl:
- [azmec](https://github.com/azmec)

### Libraries Used
- [bump.lua](https://github.com/kikito/bump.lua) - An AABB collision detection library for Lua.
- [Concord](https://github.com/Tjakka5/Concord) - A feature-complete ECS library.
- [hump.gamestate](https://hump.readthedocs.io/en/latest/gamestate.html) - Easy gamestate management for Lua.
- [pprint](https://github.com/rosejn/lua-pprint) - Pretty printing for Lua.
- [ProFi](https://gist.github.com/rm-code/383c98a6af04652ed9f39b7ae536bcc5) - A simple LuaJIT-compatible Lua profiler.
- [Push](https://github.com/Ulydev/push) - A simple resolution-handling library for LOVE.
- [tween.lua](https://github.com/kikito/tween.lua) - Tweening/Easing/Interpolating functions for Lua inspired by jQuery's animated method.