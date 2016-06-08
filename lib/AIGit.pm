package AIGit;

use parent Git::Repository;

sub new {

	my ($class, $work_tree) = @_;

	return $class->SUPER::new(
		work_tree => $work_tree, {
			git => '/usr/local/bin/git',
			env => {
				GIT_COMMITTER_EMAIL => 'gbhat@pobox.com',
				GIT_COMMITTER_NAME  => 'Gurunandan Bhat',
			},
		}
	);
}

sub build {

	my $self = shift;

	my @log = $self->run(reset => '--hard', 'newai/master');
	push @log, ($self->run(pull => 'newai',  'master'));

	my @action = `/home/gbhat/repos/AICode/bin/aiweb.pl test`;
	push @log, @action;

	return \@log;
}

1;
