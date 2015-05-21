# Install sqlmap
class sqlmap (
  $installdir = '/usr/share/sqlmap',
  $source = 'https://github.com/sqlmapproject/sqlmap.git',
  $path = '/usr/local/bin',
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
  file { "${path}/sqlmap":
    ensure  => link,
    target  => "${installdir}/sqlmap.py",
    require => Vcsrepo['sqlmap'],
  }
}
