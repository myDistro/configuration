# creates link for the main script.
define configuration::create_link(
  $target,
  $source, 
  $path_to_config,
  $owner,
){
  file { $target:
    ensure  => 'link',
    target  => "${path_to_config}/${source}",
    owner   => $owner,
    require => Vcsrepo[$path_to_config],
  }
}
