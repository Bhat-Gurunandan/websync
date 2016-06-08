#!/usr/bin/env perl
use Mojolicious::Lite;

use Data::Dumper;
use Digest::HMAC_SHA1 qw{ hmac_sha1_hex };
use Mojo::JSON qw{ decode_json };

use lib qw{ lib };
use AIGit;

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};

post '/github/hooks/push' => sub {

	my $c = shift;
	my $payload = $c->req->body;
	my $env = $c->req->env;

	my $digest = $c->req->headers->header('X-Hub-Signature');
	my $check = 'sha1=' . hmac_sha1_hex($payload, 'StriverConniver');

	$c->app->log->debug('Digest ' . ($digest eq $check ? 'matches' : 'does not match'));
	$c->app->log->debug('Payload : ' . Dumper(decode_json($payload)));

	my $repo = AIGit->new('/home/gbhat/repos/AlmostIsland');
	my $response = $repo->build;

	$c->app->log->debug('Response :' . Dumper($response));

	$c->render(text => 1);
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
<h1>Welcome to the Mojolicious real-time web framework!</h1>
To learn more, you can browse through the documentation

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
