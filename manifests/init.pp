# Install sqlmap
class sqlmap {

  # Path to installation directory
  $installdir = '/usr/share/sqlmap'

  # Create directory to install into
  file { $installdir:
    ensure => directory,
  }

  # Clone sqlmap from Github
  vcsrepo { 'sqlmap':
    ensure   => present,
    provider => git,
    path     => $installdir,
    source   => 'https://github.com/sqlmapproject/sqlmap.git',
    require  => File[$installdir],
  }

  # Symlink the main script into a bin dir
  file { '/usr/local/bin/sqlmap':
    ensure  => link,
    target  => "$installdir/sqlmap.py",
    require => Vcsrepo['sqlmap'],
  }
}
