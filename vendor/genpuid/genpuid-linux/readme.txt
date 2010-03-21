=============================================================================
GenPUID v1.4
-----------------------------------------------------------------------------

Build Date: October 31, 2008

Platforms: Win32, Linux, Mac OS X

-----------------------------------------------------------------------------
The MusicIP product team welcomes your comments! Please contact us by writing
musicdns-feedback@musicip.com.
=============================================================================

INSTALLATION
============

GenPUID is a utility distributed as part of MusicDNS. The installation is as
simple as placing it in the directory you want the binary to reside in.
Please note that both the mipcore and AACTagReader binaries need to be in the
same directory, as GenPUID requires both in order to execute properly.

NOTE: AACTagReader is not used on Linux since AAC files are not supported.
AACTagReader on Mac OS X is the only component which is not a Universal
Binary.  This will be addressed in a future release, but should pose no
issues as it works acceptably under the emulation layer in OS X.


INSTRUCTIONS
============

From the command line, run:
genpuid [dns-key] [options] file1 file2 ...

This will identify the files, invoking fingerprints and analysis as
necessary, and print out the PUID retrieved from MusicDNS.

Your MusicDNS key (used by the parameter [dns-key]) must be valid. Keys can
be generated for free at: http://musicip.com/dns/key.jsp.

----------
I. OPTIONS
----------

[*] -aac={on|off}
	By default genpuid will not modify AAC files. Using the -aac=on option
	changes this behavior to allow, for instance, the -archive option to
	be used.

[*] -archive
	Write MusicIP tags into the song files as they are identified.
	(MusicMagic Data and MusicMagic Fingerprint). 

[*] -data
	Returns the analysis data.

[*] -exclude {expression}
	Ignores files matching the given expression. The expression syntax is
	available at http://www.musicip.com/mixer/powersearch.jsp
	
	Example: -exclude length<120 
		Excludes all songs less than 120 seconds in length.

	Example: -exclude genre=Polka
		Excludes all songs of the genre Polka.

        Note that some characters, like <, may have special meanings to
        your shell, and will need to be escaped appropriately.

[*] -ext={comma-separated extension list}
	Returns extra metadata in the response.
	Extension values:
		data: Returns the analysis data
		lyrics: Return LyricFind song lyrics. Requires an extra license.
			Contact a MusicIP sales representative for more info.
		mb: Returns metadata from the MusicBrainz database.

[*] -fs={encoding type}
	Linux Only - Indicates a character encoding type to use for reading
        files.  This applies only to the filenames, and not the metadata inside
        the files. Typically this is set to "ISO8859-1". The encoding should 
        match the underlying file system.

[*] -logex
	Creates a log file in the directory from which GenPUID is being
	executed.

[*] -m3lib={filename}
	Used to store the results in a MusicIP Mixer cache file. If the cache
	already exists, it will be updated. If an m3lib file is passed
	to genPUID and no music files or directories are passed for processing,
	data will be retrieved and output for all songs in the m3lib.

[*] -m3xml={filename}
	Creates an M3XML file as output. Using a new file name to the option
	and passing a m3lib file with the -m3lib={filename} option will read
	the m3lib file and create an m3xml file from the contents.
		Example: -m3xml=newfile.m3xml -m3lib=existingfile.m3lib

[*] -noanalysis
	Does not return analysis data or create new PUIDs for tracks.

[*] -nopath
	Excludes full file paths for the tracks in the XML output.

[*] -nopuid
	Bypass the PUID lookup. Useful for just analyzing files.

[*] -nosha
	Bypass the SHA1 lookup.

[*] -print
	Returns the fingerprint.
	
[*] -proxy (proxy host)
	Defines the proxy host to use. Default port is 8080.
	
[*] -proxy_port (port number) 
     Optional. Defines a proxy port to use with the proxy host. 

[*] -proxy_user (username) 
     Optional. Defines the proxy username to use with the proxy host.

[*] -proxy_pass (password)
     Optional. Defines the proxy password to use with the proxy username. 
		
[*] -qtmp3
	Windows Only - Use the QuickTime decoder on MP3 files. May be useful
	for analyzing files which are marked unanalyzable.

[*] -r
	Pass directories to be processed. Recursively processes all 
	sub-directories.

[*] -rmd={1|2}
	Returns extra metadata.
		1: Include basic artists name and track title metadata
		2: Include extra metadata (release year, genre)

[*] -threads={number of threads}
	Run genPUID in multithread mode to improve performance.

[*] -v
	Print version number and exit.

[*] -xml[={xml output file}]
	Generate output in XML format. An optional output file can be specified.


-----------
II. RESULTS
-----------

[*] When asked to return metadata (using the -xml) switch, the following will
	be returned:

    <genpuid songs="1">
    	<track file="c:\path\file.mp3" puid="123-456" />
    </genpuid>

	If the -xml switch is not used, the result will appear as follows:
	
	c:\path\file.mp3
	puid: 123-456
	
	If a PUID does not exist for the given file, just the file name will be
	returned.

[*] If a track does not have a PUID, the status returned will be
	"Unavailable." The example below also takes into account that the -xml
	switch is enabled.

    <genpuid songs="1">
    	<track file="c:\path\file.mp3" status="unavailable"></track>
    </genpuid>

	Please note that the "unavailable" status only applies when using the
	-noanalysis switch.

NOTE: Metadata and status information will not be returned in any format 
other than UTF-8 encoded XML.

-----------
III. STATUS
-----------

If the requested metadata or associated PUID, the following status codes will
be returned accordingly:

[*] Pending 
	The server has not yet generated a PUID for this track, which can take up
	to 24 hours. If you have submitted a fingerprint for PUID creation, you 
	will need to re-request it from GenPUID after that time frame has lapsed.
	
[*] Unanalyzable
	GenPUID could not analyze the track, and this status may indicate an 
	encoding problem.

[*] Unknown
	Catch-all for other problems, such as the MusicDNS server being down.
	
[*] Unavailable
	This status indicates that the track provided to GenPUID does not yet
	have a PUID in the MusicIP database. To ensure the track is identifiable
	in the future, analysis can be executed.

----------------
IV. KNOWN ISSUES
----------------

[*] On Mac OS X when running from the shell and processing aac files, several
	lines of operating system level error messages may be printed.
	
Contact
=======

To post questions regarding GenPUID, please visit our forums at
http://forums.musicip.com/. You can also provide bug reports and enhancement
requests to the MusicIP product team by e-mailing 
musicdns-feedback@musicip.com.

© 2007-2008 MusicIP Corporation. All rights reserved.
