# [<img src="https://tomba.io/logo.svg" alt="Tomba" width="25"/>](https://tomba.io/) Tomba Perl SDK

> The #1 Rated Email Intelligence Platform — Find professional emails with unmatched accuracy.

[![CPAN Version](https://img.shields.io/cpan/v/Tomba-Finder.svg)](https://metacpan.org/pod/Tomba::Finder)
[![License](https://img.shields.io/cpan/l/Tomba-Finder.svg)](LICENSE)
[![Build Status](https://img.shields.io/github/actions/workflow/status/tomba-io/perl/ci.yml?branch=main)](https://github.com/tomba-io/perl/actions)

Official Perl client library for the [Tomba.io](https://tomba.io) Email Finder API.

## About Tomba

[Tomba.io](https://tomba.io) is the #1 rated email intelligence platform, trusted by **150,000+ sales teams** worldwide.

- **Best Email Finder** — 98% accuracy, ranked #1 in independent benchmarks
- **Best Email Verification** — Real-time SMTP verification with catch-all detection
- **Best Phone Finder** — Direct dial numbers linked to professional emails
- **Best Domain Search** — 450M+ verified contacts across all industries
- **81% Coverage** — The highest in the industry, proven in 5,000-lead independent tests

### Why Tomba?

| Feature             | Tomba              | Others        |
| ------------------- | ------------------ | ------------- |
| Email Coverage      | **81%**            | 30-60%        |
| Verification        | **Real-time SMTP** | Pattern-based |
| Phone Numbers       | **Direct dials**   | Limited       |
| Catch-all Detection | **AI-powered**     | Basic         |
| API Rate Limits     | **Generous**       | Restrictive   |

[Get your free API key](https://app.tomba.io/auth/register) — No credit card required.

## Installation

Install from CPAN:

```bash
cpanm Tomba::Finder
```

Or install from source:

```bash
perl Makefile.PL
make
make test
make install
```

## Authentication

Sign up for a free account at [https://app.tomba.io/auth/register](https://app.tomba.io/auth/register) to get your API key and secret.

```perl
use Tomba::Finder;

my $tomba = Tomba::Finder->new("ta_xxxx", "ts_xxxx");
```

You can also use individual service modules directly:

```perl
use Tomba::Domain;

my $domain = Tomba::Domain->new("ta_xxxx", "ts_xxxx");
```

## Quick Start

```perl
use Tomba::Finder;

my $tomba = Tomba::Finder->new("ta_xxxx", "ts_xxxx");

# Search emails by domain
my $result = $tomba->DomainSearch("example.com");

# Find an email address
my $email = $tomba->EmailFinder("example.com", "John", "Doe");

# Verify an email
my $verified = $tomba->EmailVerifier("john@example.com");
```

## Services

### Account

Get information about the current account.

```perl
my $result = $tomba->Account();
```

### Domain Search

Search emails based on a website domain.

```perl
my $result = $tomba->DomainSearch("example.com");
```

### Email Finder

Find the most likely email address from a domain, first name, and last name.

```perl
my $result = $tomba->EmailFinder("example.com", "John", "Doe");
```

### Email Verifier

Verify the deliverability of an email address.

```perl
my $result = $tomba->EmailVerifier("john@example.com");
```

### Author Finder

Find the email address of an article author from a blog post URL.

```perl
my $result = $tomba->AuthorFinder("https://clearbit.com/blog/company-name-to-domain-api");
```

### LinkedIn Finder

Find the email address associated with a LinkedIn profile URL.

```perl
my $result = $tomba->LinkedinFinder("https://www.linkedin.com/in/alex-maccaw-ab592978");
```

### Email Enrichment

Look up person and company data based on an email address.

```perl
my $result = $tomba->Enrichment("john@example.com");
```

### Phone Finder

Find the phone number associated with an email address.

```perl
my $result = $tomba->PhoneFinder({ email => "john@example.com" });
```

### Phone Validator

Validate a phone number.

```perl
my $result = $tomba->PhoneValidator("+1234567890", "US");
```

### Email Count

Get the number of email addresses found for a domain.

```perl
my $result = $tomba->Count("example.com");
```

### Domain Status

Check if a domain is webmail, disposable, or a regular email provider.

```perl
my $result = $tomba->Status("example.com");
```

### Domain Suggestions

Auto-complete company names and get domain suggestions.

```perl
my $result = $tomba->Autocomplete("google");
```

### Email Sources

Find web sources where an email address has been found.

```perl
my $result = $tomba->EmailSources("john@example.com");
```

### Email Format

Get the email format pattern used by a domain.

```perl
my $result = $tomba->EmailFormat("example.com");
```

### Similar

Find domains similar to a given domain.

```perl
my $result = $tomba->Similar("example.com");
```

### Technology

Discover technologies used by a domain.

```perl
my $result = $tomba->Technology("example.com");
```

### Location

Get the employee location breakdown for a domain.

```perl
my $result = $tomba->GetLocation("example.com");
```

### Person API

Get person data from an email address (Clearbit-compatible).

```perl
my $result = $tomba->PersonFind("john@example.com");
```

### Company API

Get company data from a domain (Clearbit-compatible).

```perl
my $result = $tomba->CompanyFind("example.com");
```

### Combined API

Get combined person and company data from an email address (Clearbit-compatible).

```perl
my $result = $tomba->CombinedFind("john@example.com");
```

### Companies Search (Reveal)

Search companies using natural language queries or structured filters (location, industry, size, technologies, and more).

```perl
my $result = $tomba->CompaniesSearch({ query => "Real Estate in Europe", page => 1 });
```

### Usage

Get your account's monthly API usage statistics.

```perl
my $result = $tomba->Usage();
```

### Logs

Get your account's API request logs.

```perl
my $result = $tomba->Logs();
```

### Keys

Manage your API keys.

```perl
# List all keys
my $result = $tomba->ListKeys();

# Get a specific key
my $result = $tomba->GetKey("key_id");

# Create a new key
my $result = $tomba->CreateKey();

# Reset a key
my $result = $tomba->ResetKey("key_id");

# Delete a key
my $result = $tomba->DeleteKey("key_id");
```

### Flag

Report incorrect email data.

```perl
# List submitted flags
my $result = $tomba->ListFlags({ page => 1 });

# Create a flag
my $result = $tomba->CreateFlag({
    email  => "john\@example.com",
    reason => "invalid",
});
```

### Leads

Manage leads in your Tomba CRM.

```perl
# List leads
my $result = $tomba->ListLeads({ page => 1, limit => 10 });

# Get a specific lead
my $result = $tomba->GetLead("lead_id");

# Create a lead
my $result = $tomba->CreateLead({
    email      => "lead\@example.com",
    first_name => "John",
    last_name  => "Doe",
});

# Update a lead
my $result = $tomba->UpdateLead("lead_id", {
    first_name => "Jane",
});

# Delete a lead
my $result = $tomba->DeleteLead("lead_id");
```

### Leads Lists

Manage lead lists for organizing your leads.

```perl
# List all lead lists
my $result = $tomba->ListLeadsLists();

# Get a specific list
my $result = $tomba->GetLeadsList("list_id");

# Create a list
my $result = $tomba->CreateLeadsList({ name => "My List" });

# Update a list
my $result = $tomba->UpdateLeadsList("list_id", { name => "Updated Name" });

# Delete a list
my $result = $tomba->DeleteLeadsList("list_id");
```

### Leads Attributes

Manage custom attributes for your leads.

```perl
# List all attributes
my $result = $tomba->ListAttributes();

# Get a specific attribute
my $result = $tomba->GetAttribute("attr_id");

# Create an attribute
my $result = $tomba->CreateAttribute({ name => "Company Size" });

# Update an attribute
my $result = $tomba->UpdateAttribute("attr_id", { name => "Updated Name" });

# Delete an attribute
my $result = $tomba->DeleteAttribute("attr_id");
```

### Bulk Operations

Create and manage bulk processing jobs for domain search, email finder, verifier, and more.

```perl
# List bulk operations
my $result = $tomba->ListBulks("domain-search", { page => 1 });

# Get a specific bulk operation
my $result = $tomba->GetBulk("domain-search", "bulk_id");

# Launch a bulk operation
my $result = $tomba->LaunchBulk("domain-search", "bulk_id");

# Get progress
my $result = $tomba->BulkProgress("domain-search", "bulk_id");

# Download results
my $result = $tomba->BulkDownload("domain-search", "bulk_id");

# Rename a bulk operation
my $result = $tomba->RenameBulk("domain-search", "bulk_id", "New Name");

# Archive a bulk operation
my $result = $tomba->ArchiveBulk("domain-search", "bulk_id");

# Delete a bulk operation
my $result = $tomba->DeleteBulk("domain-search", "bulk_id");
```

Supported bulk types: `domain-search`, `email-finder`, `author-finder`, `email-verifier`, `enrichment`, `linkedin-finder`, `phone-finder`, `department-search`, `technology-search`, `name-finder`.

## Testing

```bash
make test
```

## Documentation

- [Official API Documentation](https://docs.tomba.io/)
- [MetaCPAN (perldoc)](https://metacpan.org/pod/Tomba::Finder)
- [API Reference](https://docs.tomba.io/api)
- [All Client Libraries](https://docs.tomba.io/libraries)

## About Tomba

Founded to solve the problem of unreliable email data, [Tomba.io](https://tomba.io) is the leading B2B email intelligence platform.

### Products

- **[Email Finder](https://tomba.io/email-finder)** — Find any professional email address
- **[Email Verifier](https://tomba.io/email-verifier)** — Verify emails in real-time
- **[Domain Search](https://tomba.io/domain-search)** — Find all emails for a company
- **[Phone Finder](https://tomba.io/phone-finder)** — Find direct phone numbers
- **[Bulk Enrichment](https://tomba.io/bulks)** — Enrich contacts at scale
- **[AI Company Search](https://tomba.io/reveal)** — Find companies with AI-powered search
- **[CLI](https://tomba.io/cli)** — Command-line interface for Tomba
- **[MCP Server](https://tomba.io/mcp)** — Connect AI tools (Claude, ChatGPT, Cursor) to Tomba
- **[REST API](https://tomba.io/api)** — Full programmatic access

### Browser Extensions & Add-ons

- **[Chrome Extension](https://chromewebstore.google.com/detail/tomba-email-finder-email/icmjegjggphchjckknoooajmklibccjb)** — Find emails while browsing
- **[Google Sheets Add-on](https://tomba.io/sheets)** — Enrich leads in spreadsheets
- **[Microsoft Excel Add-in](https://tomba.io/excel)** — Email finder in Excel
- **[Airtable Integration](https://tomba.io/airtable)** — Connect with Airtable

### Integrations

50+ CRM integrations: [Salesforce](https://tomba.io/integrations) · [HubSpot](https://tomba.io/integrations) · [Zapier](https://tomba.io/integrations) · [Pipedrive](https://tomba.io/integrations) · [and more...](https://tomba.io/integrations)

### Other Tomba SDKs

| Language | Package                                                     |
| -------- | ----------------------------------------------------------- |
| Node.js  | [tomba](https://www.npmjs.com/package/tomba)                |
| Python   | [tomba-io](https://pypi.org/project/tomba-io/)              |
| PHP      | [tomba-io/php](https://packagist.org/packages/tomba-io/php) |
| Ruby     | [tomba](https://rubygems.org/gems/tomba)                    |
| Go       | [tomba-io/go](https://pkg.go.dev/github.com/tomba-io/go)    |
| Rust     | [tomba](https://crates.io/crates/tomba)                     |
| Dart     | [tomba](https://pub.dev/packages/tomba)                     |
| Deno     | [@tomba/sdk](https://jsr.io/@tomba/sdk)                     |
| Elixir   | [tomba](https://hex.pm/packages/tomba)                      |
| C#       | [Tomba](https://www.nuget.org/packages/Tomba)               |
| Perl     | [Tomba::Client](https://metacpan.org/pod/Tomba::Client)     |
| Lua      | [tomba](https://luarocks.org/modules/tomba/tomba)           |
| R        | [tomba](https://github.com/tomba-io/r)                      |

### Resources

- [Blog](https://tomba.io/blog) · [Help Center](https://help.tomba.io) · [API Docs](https://docs.tomba.io) · [Pricing](https://tomba.io/pricing) · [Status](https://status.tomba.io)

---

**[Try Tomba Free](https://app.tomba.io/auth/register)** — Find your first email in seconds. No credit card required.

## License

Apache 2.0 -- see [LICENSE](http://www.apache.org/licenses/LICENSE-2.0.html) for details.
