package Tomba::Finder;

use 5.026001;
use strict;
use warnings;
use LWP::UserAgent;
use URI;
use JSON qw(encode_json decode_json);

our @ISA = qw();

our $VERSION = '1.0';

# Tomba base url
use constant DEFAULT_BASE_URL => 'https://api.tomba.io/v1/';  
# Account path
use constant ACCOUNT_PATH => "/me";
# Usage path
use constant USAGE_PATH => "/usage";
# Logs path
use constant LOGS_PATH => "/logs";
# Search path
use constant SEARCH_PATH => "/domain-search";
# Finder path
use constant FINDER_PATH => "/email-finder";
# Finder path
use constant FINDER_PATH => "/email-finder";
# Enrichment path
use constant ENRICHMENT_PATH => "/enrich";
# Author path
use constant AUTHOR_PATH => "/author-finder";
# Linkedin path
use constant LINKEDIN_PATH => "/linkedin";
# Verifier path
use constant VERIFIER_PATH => "/email-verifier/";
# Email Sources path
use constant SOURCES_PATH => "/email-sources";
# Email Count path
use constant COUNT_PATH => "/email-count";
# Domain status path
use constant STATUS_PATH => "/domain-status";
# Autocomplete path
use constant AUTOCOMPLETE_PATH => "/domains-suggestion";

# Preloaded methods go here.

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
sub new {
    my ($class, $apiKey,$apiSecret, $baseUrl) = @_;

    my $self = {};


    $self->{baseUrl} = DEFAULT_BASE_URL;

    if(length($apiKey) < 39)
    {
     die "Invalid Tomba api key";
    } else {
        $self->{apiKey} = $apiKey;
    }

    if(length($apiSecret) < 39)
    {
     die "Invalid Tomba api secret";
    } else {
        $self->{apiSecret} = $apiSecret;
    }
	
    bless $self, $class;

    return $self;
}
=head2 Tomba Http Call

  Arg 1: Str $path - the path portion of the URL to request
  Arg 2: HashRef $params - a hashref of query parameters to include in the URL
  Returns: JSON response, or undef on error

  Makes a GET request to Tomba Api
=cut
sub call {

	my ($self, $path, $params) = @_;



	$self->{ua} = LWP::UserAgent->new;
	$self->{ua}->default_headers(HTTP::Headers->new(
        'X-Tomba-Key' => $self->{apiKey},
        'X-Tomba-Secret' => $self->{apiSecret},
	    Accept => 'application/json'
	));
	$self->{ua}->agent("Tomba-Finder/Perl/$VERSION");

	my $url = $self->{baseUrl}.$path;

    $url .= '?' . join('&', map { $_ . '=' . $params->{$_} } keys %$params); 

    my $response = $self->{ua}->get($url);
	  if ($response->is_success)
	  {
	    $self->{body} =  decode_json($response->decoded_content);

	  }
	  else {
	  	$self->{body} = print("ERROR: " . $response->status_line() . $response->decoded_content);
	  }

	  return  $self->{body};
}

=head2 Account Information

  Returns: JSON response, or undef on error

  Get information about the current account.
=cut
sub Account {
	my ($self) = @_;
	return $self->call(ACCOUNT_PATH);
}

=head2 Domain Search

  Arg 1: Str $domain - Domain name from which you want to find the email addresses. For example, "stripe.com".
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->DomainSearch("tomba.io");
    print $data->{data}->{organization}->{description};

  Search emails are based on the website You give one domain name and it returns all the email addresses found on the internet.
=cut
sub DomainSearch {
	my ($self, $domain) = @_;

    my $params = {
        domain => $domain,
    };
    
	return $self->call(SEARCH_PATH,$params);
}

=head2 Email Count

  Arg 1: Str $domain - Domain name from which you want to find the email addresses. For example, "stripe.com".
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->Count("tomba.io");

  Get total email addresses we have for one domain.
=cut

sub Count {
	my ($self, $domain) = @_;
    my $params = {
        domain => $domain,
    };
	return $self->call(COUNT_PATH,$params);
}

=head2 Domain status

  Arg 1: Str $domain - domain name from which you want to check. For example, "gmail.com".
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->Status("gmail.com");

  Get total email addresses we have for one domain.
=cut

sub Status {
	my ($self, $domain) = @_;
    my $params = {
        domain => $domain,
    };
	return $self->call(STATUS_PATH,$params);
}

=head2 Autocomplete

  Arg 1: Str $search - A string name company or website.
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->Autocomplete("googl");

  Company Autocomplete is an API that lets you auto-complete company names and retrieve logo and domain information.
=cut
sub Autocomplete {
	my ($self, $search) = @_;
    my $params = {
        query => $search,
    };
	return $self->call(AUTOCOMPLETE_PATH,$params);
}

=head2 Email Finder

  Arg 1: Str $domain - domain name of the company, used for emails. For example, "tomba.com".
  Arg 1: Str $fname - The person's first name. It doesn't need to be in lowercase.
  Arg 1: Str $lname - The person's last name. It doesn't need to be in lowercase.
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->EmailFinder("asana.com", "Moskoz", "Dustin");

  Generates or retrieves the most likely email address from a domain name, a first name and a last name.
=cut
sub EmailFinder {
	my ($self, $domain, $fname, $lname) = @_;
    my $params = {
        domain => $domain,
        fisrt_name => $fname,
        last_name => $lname,
    };
	return $self->call(FINDER_PATH,$params);
}

=head2 Enrichment

  Arg 1: Str $domain - The email address to find data, "b.mohamed@tomba.io".
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->Enrichment("b.mohamed@tomba.io");

  The Enrichment API lets you look up person and company data based on an email, For example, you could retrieve a person’s name, location and social handles from an email
=cut
sub Enrichment {
	my ($self, $email) = @_;
    my $params = {
        email => $email,
    };
	return $self->call(ENRICHMENT_PATH,$params);
}

=head2 Author Finder

  Arg 1: Str $url - The URL of the article. For example, "https://clearbit.com/blog/company-name-to-domain-api".
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->AuthorFinder("https://clearbit.com/blog/company-name-to-domain-api");

  Generates or retrieves the most likely email address from a blog post url.
=cut
sub AuthorFinder {
	my ($self, $url) = @_;
    my $params = {
        url => $url,
    };
	return $self->call(AUTHOR_PATH,$params);
}

=head2 Linkedin Finder

  Arg 1: Str $url - The URL of the Linkedin. For example, "https://www.linkedin.com/in/alex-maccaw-ab592978".
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->LinkedinFinder("https://www.linkedin.com/in/alex-maccaw-ab592978");

  Generates or retrieves the most likely email address from a Linkedin URL.
=cut
sub LinkedinFinder {
	my ($self, $url) = @_;
    my $params = {
        url => $url,
    };
	return $self->call(LINKEDIN_PATH,$params);
}

=head2 Email Verifier

  Arg 1: Str $email - The email address you want to verify.
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->EmailVerifier("b.mohamed@tomba.io");

  Verify the deliverability of an email address.
=cut
sub EmailVerifier {
	my ($self, $email) = @_;
	return $self->call(VERIFIER_PATH.$email);
}

=head2 Email Sources

  Arg 1: Str $email - The email address you want to find sources.
  Returns: JSON response, or undef on error

sample:
    $data = $tomba->EmailSources("b.mohamed@tomba.io");

  Find email address source somewhere on the web.
=cut
sub EmailSources {
	my ($self, $email) = @_;
	return $self->call(SOURCES_PATH.$email);
}

=head2 Usage

  Returns: JSON response, or undef on error

sample:
    $data = $tomba->Usage();

  Check your monthly requests.
=cut
sub Usage {
	my ($self) = @_;
	return $self->call(USAGE_PATH);
}

=head2 Logs

  Returns: JSON response, or undef on error

sample:
    $data = $tomba->Logs();

  Returns a your last 1,000 requests you made during the last 3 months.
=cut
sub Logs {
	my ($self) = @_;
	return $self->call(LOGS_PATH);
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Tomba::Finder - Perl extension for Tomba Email Finder tomba.io

=head1 SYNOPSIS

  use Tomba::Finder;
  $tomba = Tomba::Finder->new("ta_xxxxx", "ts_xxxxx");

=head1 DESCRIPTION

This is the official Perl client library for the [Tomba.io](https://tomba.io) Email Finder API,
allowing you to:

- [Domain Search](https://tomba.io/domain-search) (Search emails are based on the website You give one domain name and it returns all the email addresses found on the internet.)
- [Email Finder](https://tomba.io/email-finder) (This API endpoint generates or retrieves the most likely email address from a domain name, a first name and a last name..)
- [Author Finder](https://tomba.io/author-finder) (Instantly discover the email addresses of article authors.)
- [Enrichment](https://tomba.io/author-finder) (The Enrichment lets you find the current job title, company, location and social profiles of the person behind the email.)
- [Linkedin Finder](https://tomba.io/author-finder) (The Linkedin lets you find the current job title, company, location and social profiles of the person behind the linkedin URL.)
- [Email Verifier](https://tomba.io/email-verifier) (checks the deliverability of a given email address, verifies if it has been found in our database, and returns their sources.)
- [Email Sources](https://developer.tomba.io/#email-sources) (Find email address source somewhere on the web .)
- [Company Domain autocomplete](https://developer.tomba.io/#autocomplete) (Company Autocomplete is an API that lets you auto-complete company names and retrieve logo and domain information.)

=head2 Documentation

=over 1

=item * official documentation

L<https://developer.tomba.io/>

=item * GitHub

L<https://github.com/tomba-io/perl>

=back

=head1 SUPPORT
You can find documentation for this module with the perldoc command.
    perldoc Tomba::Finder
You can also look for information at:

Sample codes under examples/ folder.


=head1 AUTHOR

Mohamed Ben rebia, E<lt>b.mohamed@tomba.ioE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2023 Mohamed Benrebia <b.mohamed@tomba.io>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

L<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut
