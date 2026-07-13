---
name: owasp-code-review
description: Perform a full OWASP Top 10 code review checklist on any codebase
triggers:
  - conducting a security review or audit
  - preparing for production release
  - reviewing code for common web application vulnerabilities
version: 1.0.0
author: VibeGuard
---

# OWASP Code Review

## When This Activates
- You need to audit a codebase before production launch
- You are reviewing a pull request with security implications
- You want a systematic security assessment of an existing application

## Security Checklist
1. **A01 Broken Access Control**: Verify role-based access controls on every endpoint
2. **A02 Cryptographic Failures**: Check for HTTPS enforcement, no plaintext storage of sensitive data
3. **A03 Injection**: Search for SQL, NoSQL, OS command, and LDAP injection vectors
4. **A04 Insecure Design**: Review business logic for race conditions and insecure flows
5. **A05 Security Misconfiguration**: Check for default credentials, verbose error messages, unnecessary features
6. **A06 Vulnerable Components**: Verify all dependencies are patched and scanned
7. **A07 Auth Failures**: Confirm password policies, session timeouts, and MFA availability
8. **A08 Data Integrity**: Validate integrity of CI/CD pipelines, software updates, and serialized data
9. **A09 Logging Failures**: Ensure security events are logged with sufficient detail
10. **A10 SSRF**: Verify server-side requests cannot be manipulated to access internal resources

## How to Use
1. Map each OWASP category to specific files and functions in the codebase
2. Use grep to find injection points: `query(`, `exec(`, `eval(`, `innerHTML`
3. Check authentication middleware and route guards
4. Review error handling for information leakage
5. Verify all external requests use allowlists
6. Document findings with severity ratings and remediation steps

## Example Prompt
```
Perform an OWASP Top 10 code review on this codebase. Check each category: access control, cryptography, injection, insecure design, misconfiguration, vulnerable components, auth failures, data integrity, logging, and SSRF. Provide specific file references and severity ratings for each finding.
```

## Red Flags
- Missing authentication on API endpoints
- Raw SQL concatenation with user input
- Error messages exposing stack traces or database schemas
- Deserialization of untrusted data
- Missing Content-Security-Policy headers
- CORS configured as `Access-Control-Allow-Origin: *` with credentials

## Fix Patterns
- Use parameterized queries (ORMs, prepared statements)
- Implement RBAC middleware on all routes
- Return generic error messages to clients, log details server-side
- Use `helmet` (Node.js) or `django-csp` for security headers
- Validate and sanitize all inputs with allowlists
- Implement proper session management with HttpOnly, Secure, SameSite cookies

## References
- https://owasp.org/Top10/
- https://owasp.org/www-project-code-review-guide/
