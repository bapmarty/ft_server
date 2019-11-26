<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'bapmarti' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
/**#@-*/
define('AUTH_KEY',         '.>U=8Nc|NYPs>4~7+3$jU-,;.`&u&A1+gPjy(s-)ke<UthE#kx`p-X{qQ.CsLY1K');
define('SECURE_AUTH_KEY',  'qB[(xlD*hOKejv3x1,7-v1f*_c*ae-)a)@kXo}h?v/3C$}_;P|w,/*@)nr]Y%+5M');
define('LOGGED_IN_KEY',    'NCklB5+!aR #;>5km>M%7)hE+@I:P{sL_1=;}+pS<7|^ h!TQiWD@JQ-e2@$6V$d');
define('NONCE_KEY',        'qmp<_6n^mXnl)CzxsE!a@p,]k=gxLG;d|`*2Py7e;{a).=!,fg0Qzk)&eW!V@oqa');
define('AUTH_SALT',        'cXH.,Iw]Mc+1qZ2FnxV-de,iQ#^u)+8P5[6y]<3Q|60KDPoxzNr-Vni[L?b^Or0h');
define('SECURE_AUTH_SALT', '0,Ugp-<g&zB@IQ+@c$H82dDJ-cWkA$)24{0~@q>AgT,(+6EoCWZ1&`w|~;w@bm$%');
define('LOGGED_IN_SALT',   '-3-8%%Ev3.&M+<#vZ51Fmx~ #&iJq;G&lW);AxDx2Sc^50GtV?O1;W(Mq/CuoZ,_');
define('NONCE_SALT',       'Av~s vh]i&V+8;%CBH5c|a=g]%rLkU4fJ49*e<A>~74} *ojQHAB(B4++Nrk5N,]');

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
