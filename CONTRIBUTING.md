# Contributing to FormBuilder

We welcome contributions to FormBuilder! This document provides guidelines for contributing to the project.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/FormBuilder.git
   cd FormBuilder
   ```
3. **Create a new branch** for your feature or bug fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

### Prerequisites

- Xcode 15.0 or later
- Swift 6.0 or later
- iOS 16.0+ deployment target

### Building the Project

1. Open `Package.swift` in Xcode or use Swift Package Manager:
   ```bash
   swift build
   ```

2. Run tests:
   ```bash
   swift test
   ```

3. Open the example project:
   ```bash
   open FormBuilderExample/FormBuilderExample.xcodeproj
   ```

## Code Style and Conventions

### Swift Style Guidelines

- **Indentation**: Use 4 spaces (no tabs)
- **Line Length**: Maximum 120 characters
- **Naming**: Use descriptive names for variables, functions, and types
- **Access Control**: Be explicit about access levels (`public`, `internal`, `private`)

### Code Organization

- **Protocols**: Place in separate files when they're substantial
- **Extensions**: Group related functionality in extensions
- **File Structure**: Follow the existing directory structure in `Sources/FormBuilder/`

### Documentation

- **Public APIs**: Must include comprehensive documentation comments
- **Complex Logic**: Add inline comments explaining the reasoning
- **Examples**: Include usage examples in documentation when helpful

## Submitting Changes

### Before Submitting

1. **Test your changes** thoroughly
2. **Update documentation** if you've changed public APIs
3. **Add tests** for new functionality
4. **Run the example app** to ensure everything works
5. **Check for SwiftLint warnings** (if configured)

### Pull Request Process

1. **Update the README.md** if your change affects usage
2. **Ensure your PR description** clearly describes the problem and solution
3. **Reference any related issues** in your PR description
4. **Request review** from maintainers

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing performed
- [ ] Example app tested

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tests added/updated
```

## Reporting Issues

### Bug Reports

When reporting bugs, please include:

- **FormBuilder version**
- **iOS version and device**
- **Xcode version**
- **Steps to reproduce**
- **Expected vs actual behavior**
- **Code samples** (minimal reproduction case)

### Feature Requests

For feature requests, please include:

- **Clear description** of the proposed feature
- **Use case** explaining why it would be valuable
- **Proposed API** (if you have ideas)
- **Alternatives considered**

## Code of Conduct

### Our Standards

- **Be respectful** and inclusive
- **Be collaborative** and constructive
- **Focus on what's best** for the community
- **Show empathy** towards other community members

### Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported to the project maintainers.

## Questions?

If you have questions about contributing, feel free to:

- **Open an issue** for discussion
- **Check existing issues** for similar questions
- **Review the documentation** in the README

Thank you for contributing to FormBuilder! 🎉