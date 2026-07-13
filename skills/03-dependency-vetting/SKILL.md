---
name: dependency-vetting
description: Audit third-party packages for vulnerabilities, malware, and supply chain risks before installation
triggers:
  - installing new npm/pip/cargo/go packages
  - reviewing package.json, requirements.txt, or Cargo.toml
  - updating dependencies after a security advisory
version: 1.0.0
author: VibeGuard
---

# Dependency Vetting

## When This Activates
- You run `npm install`, `pip install`, or `cargo add` on a new package
- You see a pull request updating `package.json` or `requirements.txt`
- A security advisory mentions a package you use

## Security Checklist
1. Check package download count and maintainer reputation on npm/pypi
2. Run `npm audit`, `pip-audit`, or `cargo audit` before merging updates
3. Review the package source code for network requests or file system access
4. Verify the package has a recent commit and responsive maintainers
5. Check Snyk, OSV, or GitHub Security Advisories for known CVEs
6. Pin exact versions in lock files (`package-lock.json`, `poetry.lock`)
7. Review transitive dependencies (use `npm ls` or `pipdeptree`)
8. Test in an isolated environment before production deployment

## How to Use
1. Before installing: research the package on npm/pypi, check stars, issues, maintainer activity
2. Install in a temporary directory and run `npm audit` or `snyk test`
3. Use Socket.dev to scan for supply chain risks in real-time
4. Review the `postinstall` scripts in `package.json` for malicious behavior
5. Add `npm audit --audit-level=moderate` to CI pipeline
6. Set up Dependabot or Renovate for automated security updates
7. Create an allowlist of approved packages for enterprise use

## Example Prompt
```
Audit the dependencies in this project. Run npm audit or pip-audit, check for known CVEs on Snyk, review any packages with postinstall scripts, and verify lock file integrity. Flag any packages with low download counts or suspicious network/file system access.
```

## Red Flags
- Package with <100 weekly downloads and no recent commits
- `postinstall` scripts that download binaries or modify system files
- Typosquatting names (`lodashs` instead of `lodash`)
- Packages with excessive permissions (network, filesystem, child_process)
- No lock file or lock file not committed to version control

## Fix Patterns
- Use `npm ci` instead of `npm install` in CI/CD to respect lock files
- Add `snyk test` and `npm audit` to pre-merge checks
- Use `npm config set ignore-scripts true` to skip postinstall scripts
- Pin versions: `"lodash": "4.17.21"` instead of `"lodash": "^4.17.21"`
- Use private registries (Verdaccio, Artifactory) with approval workflows

## References
- https://owasp.org/www-project-dependency-check/
- https://socket.dev/
- https://github.com/pypa/pip-audit
