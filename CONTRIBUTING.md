# Contributing to Ultimate Remote Spy

First off, thank you for considering contributing to Ultimate Remote Spy! 🎉

It's people like you that make this tool better for everyone in the Roblox community.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Getting Started](#getting-started)
- [Development Guidelines](#development-guidelines)
- [Pull Request Process](#pull-request-process)
- [Style Guide](#style-guide)
- [Community](#community)

## 📜 Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

### Our Standards

- ✅ Be respectful and inclusive
- ✅ Welcome newcomers and help them learn
- ✅ Focus on what's best for the community
- ✅ Show empathy towards others
- ❌ No harassment or discriminatory language
- ❌ No trolling or insulting comments
- ❌ No publishing others' private information

## 🤝 How Can I Contribute?

### Reporting Bugs 🐛

Before creating bug reports, please check existing issues to avoid duplicates.

When creating a bug report, include:

- **Clear title** describing the issue
- **Steps to reproduce** the bug
- **Expected behavior** vs **actual behavior**
- **Screenshots** if applicable
- **Environment details**:
  - Roblox version
  - Executor used
  - RemoteSpy version
  - Game where the bug occurred

**Template:**

```markdown
**Bug Description:**
A clear description of what the bug is.

**Steps to Reproduce:**
1. Go to '...'
2. Click on '...'
3. See error

**Expected Behavior:**
What you expected to happen.

**Actual Behavior:**
What actually happened.

**Screenshots:**
If applicable, add screenshots.

**Environment:**
- Roblox Version: [e.g., 2024.1]
- Executor: [e.g., Synapse X]
- RemoteSpy Version: [e.g., 3.0.0]
- Game: [e.g., Adopt Me]
```

### Suggesting Features ✨

We love feature suggestions! Before creating one:

1. Check if it's already been suggested
2. Make sure it aligns with the project's goals
3. Be specific about the use case

**Template:**

```markdown
**Feature Title:**
Short, descriptive title

**Problem:**
What problem does this solve?

**Proposed Solution:**
Detailed description of your idea

**Alternatives:**
Any alternative solutions you've considered

**Additional Context:**
Mockups, examples, or references
```

### Improving Documentation 📚

Documentation improvements are always welcome!

- Fix typos or unclear instructions
- Add examples or tutorials
- Improve code comments
- Translate to other languages

### Contributing Code 💻

Ready to write some code? Great!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 🚀 Getting Started

### Development Setup

1. **Fork the Repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone Your Fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/RemoteSpy.git
   cd RemoteSpy
   ```

3. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

4. **Make Changes**
   - Edit the Lua files
   - Test in Roblox
   - Add comments

5. **Test Thoroughly**
   - Test in multiple games
   - Test different scenarios
   - Verify no performance impact
   - Check for edge cases

6. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Add: your feature description"
   ```

7. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

8. **Create Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Fill out the PR template

## 📝 Development Guidelines

### Project Structure

```
RemoteSpy/
├── RemoteSpy.lua          # Main script
├── AdvancedConfig.lua     # Configuration
├── Examples.lua           # Usage examples
├── README.md              # Documentation
├── CONTRIBUTING.md        # This file
└── LICENSE                # MIT License
```

### Module Organization

The main script is organized into these sections:

1. **Configuration** - User-editable settings
2. **Services & Imports** - Roblox services
3. **Utility Functions** - Helper functions
4. **Data Storage** - Log storage and management
5. **Hooking Engine** - Remote interception
6. **Exploit Detector** - Pattern detection
7. **UI Themes** - Color schemes
8. **UI Creation** - Interface components
9. **Input Handling** - Keyboard shortcuts
10. **Initialization** - Startup code

### Coding Standards

#### Naming Conventions

```lua
-- PascalCase for modules and classes
local HookEngine = {}

-- camelCase for functions
function someFunction()
end

-- SCREAMING_SNAKE_CASE for constants
local MAX_BUFFER_SIZE = 10000

-- lowercase for local variables
local playerName = "John"
```

#### Code Style

```lua
-- Use 4 spaces for indentation
function example()
    if condition then
        doSomething()
    end
end

-- Add spaces around operators
local result = a + b * c

-- Use descriptive variable names
local totalCallsPerSecond = 100  -- ✅ Good
local tcps = 100                  -- ❌ Bad

-- Comment complex logic
-- Calculate the average CPS over the last minute
local avgCPS = totalCalls / 60
```

#### Function Documentation

```lua
--[[
    Brief description of what the function does.
    
    Parameters:
        param1 (type): Description
        param2 (type): Description
    
    Returns:
        returnType: Description
        
    Example:
        local result = FunctionName(arg1, arg2)
]]
function FunctionName(param1, param2)
    -- Implementation
end
```

#### Error Handling

```lua
-- Use pcall for operations that might fail
local success, result = pcall(function()
    return riskyOperation()
end)

if success then
    print("Success:", result)
else
    warn("Error:", result)
end
```

### Testing Guidelines

#### Manual Testing Checklist

- [ ] Script loads without errors
- [ ] UI appears correctly
- [ ] All keybinds work
- [ ] Remote calls are captured
- [ ] Filtering works
- [ ] Export functions work
- [ ] No memory leaks
- [ ] Performance is acceptable
- [ ] Works in different games

#### Test in Multiple Scenarios

1. **Low Activity** - Few remote calls
2. **High Activity** - Many rapid calls
3. **Large Data** - Calls with large arguments
4. **Edge Cases** - nil, huge numbers, circular references

### Performance Considerations

- Avoid expensive operations in hooks
- Use lazy loading where possible
- Cache frequently accessed data
- Yield after processing many items
- Monitor memory usage

```lua
-- ❌ Bad - Expensive operation in hook
function hook()
    for i = 1, 1000000 do
        -- Heavy computation
    end
end

-- ✅ Good - Defer expensive work
function hook()
    spawn(function()
        for i = 1, 1000000 do
            -- Heavy computation
            if i % 100 == 0 then
                wait() -- Yield periodically
            end
        end
    end)
end
```

## 🔄 Pull Request Process

### Before Submitting

1. **Test Everything** - Make sure it works
2. **Update Documentation** - If you changed behavior
3. **Add Examples** - If you added features
4. **Check Style** - Follow the style guide
5. **Write Good Commits** - Clear, descriptive messages

### Commit Message Format

```
Type: Short description (50 chars max)

Longer description if needed (wrap at 72 chars).
Explain what and why, not how.

- Bullet points are okay
- Use present tense: "Add feature" not "Added feature"
```

**Types:**
- `Add:` New feature
- `Fix:` Bug fix
- `Update:` Update existing feature
- `Remove:` Remove feature
- `Refactor:` Code refactoring
- `Docs:` Documentation only
- `Style:` Formatting, no code change
- `Test:` Adding tests
- `Chore:` Maintenance tasks

**Examples:**

```
Add: Exploit detection for speed hacks

Implement pattern detection for players moving faster than
humanoid max speed. Tracks position history and calculates
velocity between calls.
```

```
Fix: UI not updating when logs are cleared

The UpdateLogDisplay function wasn't being called after
DataStore:Clear(). Now explicitly calls update after clear.
```

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How has this been tested?

## Checklist
- [ ] Code follows style guide
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Tested in multiple games

## Screenshots
If applicable
```

### Review Process

1. **Automated Checks** - Must pass (when implemented)
2. **Code Review** - At least one approval required
3. **Testing** - Reviewers test the changes
4. **Discussion** - Address feedback and suggestions
5. **Merge** - Once approved and all checks pass

## 🎨 Style Guide

### Lua Specific

```lua
-- Prefer local variables
local value = 10  -- ✅
value = 10        -- ❌

-- Use proper table syntax
local config = {
    setting1 = true,
    setting2 = false,
}

-- Avoid global pollution
_G.RemoteSpyData = data  -- Only if intentional

-- Use meaningful names
local playerList = {}     -- ✅
local pl = {}             -- ❌

-- Comment sections
-- ═══════════════════════════════════════
--          SECTION TITLE
-- ═══════════════════════════════════════
```

### UI Design Principles

- **Consistency** - Same style throughout
- **Clarity** - Easy to understand
- **Efficiency** - Fast and responsive
- **Accessibility** - Works for everyone
- **Beauty** - Visually pleasing

### Documentation Style

- Use markdown for all docs
- Include code examples
- Add screenshots where helpful
- Keep it concise but complete
- Update when code changes

## 👥 Community

### Communication Channels

- **GitHub Issues** - Bug reports and features
- **GitHub Discussions** - General questions
- **Discord** - Coming soon!

### Recognition

Contributors will be:
- Listed in the README
- Credited in release notes
- Given a contributor badge (when available)

### Questions?

Don't hesitate to ask! We're here to help.

- Open a Discussion on GitHub
- Comment on relevant Issues/PRs
- Join our Discord (when available)

## 📊 Development Roadmap

### Current Focus (v3.x)
- [ ] Improve performance
- [ ] Add more themes
- [ ] Plugin system
- [ ] Better documentation

### Future Plans (v4.x)
- [ ] Machine learning detection
- [ ] Real-time collaboration
- [ ] Cloud sync
- [ ] Mobile support

### Long-term Vision
- [ ] Full IDE integration
- [ ] Community plugin marketplace
- [ ] Cross-platform support
- [ ] Advanced analytics

## 🏆 Hall of Fame

Special thanks to our top contributors:
- *Your name could be here!*

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

<div align="center">

**Thank you for contributing! 🎉**

Every contribution, no matter how small, makes a difference.

[⬆ Back to Top](#contributing-to-ultimate-remote-spy)

</div>
