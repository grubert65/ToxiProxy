package ToxiProxy::ServerMock;
use v5.14;
use Moose;
use Test::LWP::UserAgent;
use JSON::XS;

our $coder = JSON::XS   ->new
                        ->utf8
                        ->allow_nonref
                        ->convert_blessed;

sub get_ua {
    my $self = shift;

    my $ua = Test::LWP::UserAgent->new();

    # GET /proxies
    $ua->map_response( 
        sub{
            my $r = shift;
            return 1 if $r->method eq 'GET' && $r->uri =~ m|proxies(/{0,1})$|;
        },
        HTTP::Response->new('200','Success', 
            ['Content-Type' => 'application/json'],
            encode_json({
              "p1"=> {
                "name"=> "p1",
                "listen"=> "127.0.0.1:8090",
                "upstream"=> "localhost:8080",
                "enabled"=> \1,
                "toxics"=> []
              }
          })
    ));

    # POST /proxies
    $ua->map_response( 
        sub{
            my $r = shift;
            return 1 if $r->method eq 'POST' && $r->uri =~ m|proxies(/{0,1})$|;
        },
        HTTP::Response->new('201','Created', 
            ['Content-Type' => 'application/json'],
            encode_json({
                "name"=> "p1",
                "listen"=> "127.0.0.1:8090",
                "upstream"=> "localhost:8080",
                "enabled"=> \1,
                "toxics"=> []
          })
    ));


    # POST /populate
    $ua->map_response( 
        sub{
            my $r = shift;
            return 1 if $r->method eq 'POST' && $r->uri =~ m|populate|;
        },
        HTTP::Response->new('201','Created', 
            ['Content-Type' => 'application/json'],
            encode_json({
                "proxies" => [{
                    "name"=> "p1",
                    "listen"=> "127.0.0.1:8090",
                    "upstream"=> "localhost:8080",
                    "enabled"=> \1,
                    "toxics"=> []
                }]
            })
        )
    );

    # GET /proxies/{proxy}
    $ua->map_response( 
        sub{
            my $r = shift;
            return 1 if $r->method eq 'GET' && $r->uri =~ m|proxies/(\w+)$|;
        },
        HTTP::Response->new('200','Success', 
            ['Content-Type' => 'application/json'],
            encode_json({
                "name"=> "p1",
                "listen"=> "127.0.0.1:8090",
                "upstream"=> "localhost:8080",
                "enabled"=> \1,
                "toxics"=> []
          })
    ));

    # POST /proxies/{proxy}
    $ua->map_response( 
        sub{
            my $r = shift;
            return 1 if $r->method eq 'POST' && $r->uri =~ m|proxies/(\w+)$|;
        },
        HTTP::Response->new('200','OK', 
            ['Content-Type' => 'application/json'],
            encode_json({
                "name"=> "p1",
                "listen"=> "127.0.0.1:8090",
                "upstream"=> "localhost:8080",
                "enabled"=> \0,
                "toxics"=> []
          })
    ));

    return $ua;
}

1; 
 

