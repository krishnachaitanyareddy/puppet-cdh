# == Class cdh4::hue
#
# Installs hue, sets up the hue.ini file
# and ensures that hue server is running.
# This requires that cdh4::hadoop::config is included.
#
class cdh4::hue(
	$secret_key            = undef,
	$ldap_url              = undef,
	$ldap_cert             = undef,
	$ldap_nt_domain        = undef,
	$ldap_bind_dn          = undef,
	$ldap_base_dn          = undef,
	$ldap_bind_password    = undef,
	$ldap_username_pattern = undef)
{
	include cdh4::hue::install

	# config needs hue installed and hadoop config defined.
	class { "cdh4::hue::config":
		secret_key            => $secret_key,
		ldap_url              => $ldap_url,
		ldap_cert             => $ldap_cert,
		ldap_nt_domain        => $ldap_nt_domain,
		ldap_bind_dn          => $ldap_bind_dn,
		ldap_base_dn          => $ldap_base_dn,
		ldap_bind_password    => $ldap_bind_password,
		ldap_username_pattern => $ldap_username_pattern,
		require               => [Class["cdh4::hue::install"], Class["cdh4::hadoop::config"]],
	}

	# The hue service subscribes to the hue config file.
	class { "cdh4::hue::service": 
		require => Class["cdh4::hue::config"],
	}
}
