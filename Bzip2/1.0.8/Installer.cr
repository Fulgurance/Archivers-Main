class Target < ISM::Software

    def prepare
        super

        fileReplaceText(path:       "#{buildDirectoryPath}/Makefile",
                        text:       "ln -s -f $(PREFIX)/bin/",
                        newText:    "ln -s -f ")

        fileReplaceText(path:       "#{buildDirectoryPath}/Makefile",
                        text:       "$(PREFIX)/man",
                        newText:    "$(PREFIX)/share/man")

        makeSource( arguments:  "-f Makefile-libbz2_so",
                    path:       buildDirectoryPath)

        makeSource( arguments:  "clean",
                    path:       buildDirectoryPath)
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:  "PREFIX=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr install",
                    path:       buildDirectoryPath)

        copyFile(   "#{buildDirectoryPath}/libbz2.so.*",
                    "#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/lib")

        copyFile(   "#{buildDirectoryPath}/bzip2-shared",
                    "#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/bin/bzip2")

        deleteFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/lib/libbz2.a")
        deleteFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/bin/bzcat")
        deleteFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/bin/bunzip2")

        makeLink(   target: "libbz2.so.1.0.8",
                    path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/libbz2.so",
                    type:   :symbolicLink)

        makeLink(   target: "bzip2",
                    path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/bzcat",
                    type:   :symbolicLinkByOverwrite)

        makeLink(   target: "bzip2",
                    path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/bunzip2",
                    type:   :symbolicLinkByOverwrite)
    end

end
