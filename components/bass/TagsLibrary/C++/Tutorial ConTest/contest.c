/*
	Tags Library simple console tutorial
	Copyright (c) 2014 www.3delite.hu
*/

#define _UNICODE

#include <stdlib.h>
#include <stdio.h>
#include "Tchar.h"
#include "TagsLibraryDefs.h"

#ifdef _WIN32 // Windows
#include <conio.h>
#else // OSX
#include <sys/time.h>
#include <termios.h>
#include <string.h>
#include <unistd.h>
#endif

void main(int argc, char **argv)
{
	//* Get unicode command line argument list
	LPWSTR *szArglist;
	int nArgs;

	szArglist = CommandLineToArgvW(GetCommandLineW(), &nArgs);

	if (NULL == szArglist)
	{
		wprintf(L"\n\tCommandLineToArgvW failed\n");
		return;
	}

	//* No argument specified
	if (argc != 2) {
		printf("\n\tUsage: contest <file>\n");
		return;
	}

	//* Load the .dll
	if (!InitTagsLibrary()) {
		//* Could not load the .dll
		printf("\n\tError while loading TagsLib.dll.\n");
		return;
	}

	//* Create a Tags instance
	HTAGS Tags = TagsLibrary_Create();

	//* Load the tags szArglist is unicode! ttAutomatic means auto detect and load all supported tag formats
	TagsLibrary_Load(Tags, szArglist[1], ttAutomatic, TRUE);

	//* Successfully loaded tags
	if (TagsLibrary_Loaded(Tags, ttAutomatic)) {

		int i;
		TExtTag ExtTag;

		//* Query how many text tags are loaded
		int TagCount = TagsLibrary_TagCount(Tags, ttAutomatic);
		printf("\nTag count=%d\n", TagCount);

		//* List all tags
		for (i = 0; i < TagCount; i++) {
			TagsLibrary_GetTagByIndexEx(Tags, i, ttAutomatic, &ExtTag);
			printf("%ws=%ws\n", ExtTag.Name, ExtTag.Value);
		}
	}
	else
	{
		printf("No tags found in file.\n");
	}

	//* Don't need the Tags instance any more
	TagsLibrary_Free(Tags);

	//* Unload the .dll
	FreeTagsLibrary();

	// Free memory allocated for CommandLineToArgvW arguments.
	LocalFree(szArglist);

}
