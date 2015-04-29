class people::samjsharpe::repos {

    $home              = "/Users/${::luser}"
    $home_projects     = "${home}/Projects"

    file {[
        "${home_projects}/gds",
        "${home_projects}/samjsharpe",
    ]:
        ensure => directory
    }

    # GDS Repos
    people::samjsharpe::repos::gds {[
        'gds/alphagov-deployment',
        'gds/deployment',
        'gds/govuk-provisioning',
        'gds/opsmanual',
        'gds/private-utils',
        'gds/puppet',
        ]:}

    file {"${boxen::config::srcdir}/gds/puppet/development/Vagrantfile.localconfig":
      source => 'puppet:///modules/people/samjsharpe/Vagrantfile.localconfig',
      require => People::Samjsharpe::Repos::Gds['gds/puppet']
    }

    people::samjsharpe::repos::gh  {[
        'alphagov/fabric-scripts',
        'alphagov/vagrant-govuk',
        'samjsharpe/vagrant-centos',
        'samjsharpe/vagrant-ubuntu'
        ]:}

    people::samjsharpe::repos::gh  {'samjsharpe/dotfiles': notify => Exec['samjsharpe-link-my-dotfiles'] }
    exec {'samjsharpe-link-my-dotfiles':
      command     => "${home_projects}/samjsharpe/dotfiles/link.sh",
      refreshonly => true,
    }

}
