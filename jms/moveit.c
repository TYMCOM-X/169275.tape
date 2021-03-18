#include <stdio.h>
#include <sys/types.h>
#include <ctype.h>
#include <string.h>

#define TRUE 1
#define FALSE 0
#define MAXPATH 100
#define MAXCWD 80

char	buf[MAXPATH+2];	/* one line - 100 chars in filename */

char	bakdir[]="/backup";
char	tymdir[]="/tym";
char	piload[]="/piload";

char	cwd[MAXCWD];	/* file current working dir */
char	path[40];	/* file path '/tym/2/02237' */
char	last[40];	/* last file path for speed */
char	group[6];	/* file group '2'           */
char	name[3+1]="";	/* file name  't01'         */

int	isgood=0;	/* is a valid file: (nd* n* bk* b*) */
int	isback=0;	/* belongs in /tym/n/node/backup? = no */
int	isload=0;	/* belongs in /piload/node? = no */
int	isacmd=0;	/* file is a cmd type of file */
int	isanib=0;	/* file is a nib type of file */

int	nodenum=0;	/* node number */
int	groupnum=0;	/* group number */

main(argc, argv)
int	argc;
char	*argv[];
{
char	*line;
int	c, x;

	if ( argc > 2 ) {
	   fprintf(stderr, "Usage: %s infile outfile\n\n", argv[0]);
	   exit(1);
	}

	/* open the input file if specified */
	if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL)) {
	   fprintf(stderr, "can't open infile %s for read!\n", argv[1]);
	   exit(1);
	}

	/* open the output file if specified */
	if ((argc > 2) && (freopen(argv[2], "w", stdout) == NULL)) {
	   fprintf(stderr, "can't open outfile %s for write!\n", argv[2]);
	   exit(1);
	}

	getcwd( cwd, MAXCWD );

	while ( (line = fgets(buf, MAXPATH, stdin)) != NULL ) {
		isback = isload = isgood = isacmd = isanib = FALSE;
		groupnum = nodenum = 0;
		if ( ( line[0] == 'b' ) &&
		     ( line[1] == 'k' || isdigit( line[1] ) ) ) {
			isgood = isback = TRUE;
		}
		if ( line[0] == 't' && isdigit( line[1] ) )
			isload = isgood = TRUE;
		if ( line[0] == 'n' ) {
			if ( line[1] == 'w' )
				isload = isgood = TRUE;
			if ( line[1] == 'd' || isdigit( line[1] ) )
				isgood = TRUE;
		}
		if ( isgood ) {
			if ( isdigit( line[1] ) ) {
				nodenum  = atoi( &line[1] );
				groupnum = ((line[1] - '0') * 10) + (line[2] - '0');
			}
			else {
				nodenum  = atoi( &line[2] );
				groupnum = line[2] - '0';
				if ( line[2] == '0' || line[2] == '1' ) {
					nodenum = nodenum + 10000;
					if ( groupnum < 10 )
						groupnum = groupnum + 10;
				}
			}
		}

		if ( !isgood  ||  line[6] != '.' ) {
			fprintf( stderr, " *** (%d) [%c] %s",
					 isgood, line[6], line );
			for ( x=0; line[x] != '\0'; x++ )
				if ( line[x] == '\n' )
					line[x] = '\0';
			fprintf( stdout, "mv %s/%s %s/../xtra\n",
					 cwd, line, cwd );
		}
		else {
			char *temp;
			if (temp=strchr(line,'\n')) *temp = '\0';
			else	line[10] = '\0';
			strncpy( name, &line[7], 3 );
			sprintf( group, "/%d", groupnum );
			sprintf( path, "%s%s/%.5d",
				isload ? piload : tymdir,
				isload ? ""     : group,
				nodenum );

			if ( name[0] == 'c' )
				isacmd = TRUE;

			if ( name[0] == 'b' && name[1] == 'n' && name[2] == 'd' )
				isanib = TRUE;
			if ( name[0] == 'n' && name[1] == 'i' && name[2] == 'b' )
				isanib = TRUE;
			if ( name[0] == 'n' &&isdigit(name[1])&&isdigit(name[2]) )
				isanib = TRUE;

			if ( isanib ) {
				fprintf( stdout, "rm %s/%s\n", cwd, line );
			}
			else {

				if ( strcmp( path, last ) != 0 )
					printf( "if ! ( -e %s ) mkdir %s\n", path, path );

				if ( isback )
					printf( "if ! ( -e %s%s ) mkdir %s%s\n",
						path, bakdir, path, bakdir );

				printf( "%s %s/%s %s %s%s/%s\n",
					isacmd ? "sed -f /usr/tym/tym.sed" : "mv",
					cwd, line,
					isacmd ? ">" : "",
					path,
					isback ? bakdir : "",
					name );

				if ( isacmd ) {
					printf( "mv %s/%s %s/../cmds\n",
						cwd, line, cwd );
				}
				strcpy( last, path );
			}

		}
				
	}

	exit(1);

}

