# Install sqlmap
class sqlmap (
  $installdir = '/usr/share/sqlmap',
  $source = 'https://github.com/sqlmapproject/sqlmap.git',
) {

  # Create directory to install into
  file { $installdir:
    ensure => directory,
  }

  # Clone sqlmap from Github
  vcsrepo { 'sqlmap':
    ensure   => present,
    provider => git,
    path     => $installdir,
    source   => $source,
    require  => File[$installdir],
  }

  # Symlink the main script into a bin dir
  file { '/usr/local/bin/sqlmap':
    ensure  => link,
    target  => "$installdir/sqlmap.py",
    require => Vcsrepo['sqlmap'],
  }
}
