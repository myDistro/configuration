/* creates link for the main script. */
define configuration::create_link(
  $source, 
  $target,
  $path_to_config,
  $owner,
){
  #notify { "ln -s ${path_to_config}/${source} ${target}": }
  file { "${path_to_config}/${source}":
    ensure  => "link",
    target  => $target,
    owner   => $owner,
    require => Vcsrepo[$path_to_config],
  }
}
