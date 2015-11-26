# == Class: freetds
#
# Install packages needed for php development
#
class freetds {
  exec { 'freetds-defaults':
    command => 'sudo sed -i "s/;\ttds version = 4.2/\ttds version = 8.0\n\tclient charset = UTF-8/" /etc/freetds/freetds.conf',
    require => Exec['apt-get update']
  }

  exec { 'freetds-locale':
    notify  => Service['apache2'],
    require => Exec['freetds-defaults'],
    command => 'printf "[default]\n\tdate format = %%Y-%%m-%%d %%H:%%M:00\n" | sudo tee /etc/freetds/locales.conf &>/dev/null'
  }
}
