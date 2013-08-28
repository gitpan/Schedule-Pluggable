package Schedule::Pluggable::Plugin::JobsFromXMLTemplate;
use Moose::Role;
use XML::Simple;
use Template;
use Carp qw/ croak /;

sub get_job_config {
    my $self = shift;
    my $params = shift;
    my $jobs = undef;
    if ($params->{Jobs}) {
        if (-f $params->{Jobs}) {
            my $tt = new Template({EVAL_PERL => 1});
            my $processed;
            $tt->process($params->{Jobs}, $self, \$processed);
            $jobs = XMLin($processed, KeyAttr=>{ name => 'name1'});
        }
        else {
            croak("Xml input file $params->{Jobs} does not exist");
        }
    }
    else  {
        croak("Mandator Parameter Xml input file Jobs missing for JobsFromXML");
    }
    return $jobs->{Job};
}
1;
__END__

=head1 NAME

Schedule::Pluggable::Plugin::JobsFromXMLTemplate - Plugin Role for Schedule::Pluggable to obtain Job configuration from a Template toolkit XML file

=head1 METHODS

=over

=item get_job_config

get_job_config is the only method in this plugin and is returns the job config from and XML file
It expects a mandatory hashref which has a key Jobs containing the name of a file which contains the xml job configuration.
As the name suggests, the file is also processed by Template::Toolkit


=back

=cut
