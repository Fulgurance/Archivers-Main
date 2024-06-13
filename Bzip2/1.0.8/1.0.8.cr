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

        deleteFile("#{buildDirectoryPath}/libbz2.so.1.0")
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def build32Bits

        makeSource( arguments:  "clean",
                    path:       buildDirectoryPath)

        fileReplaceText(path:       "#{buildDirectoryPath}/Makefile",
                        text:       "CC=gcc",
                        newText:    "CC=gcc -m32")

        fileReplaceText(path:       "#{buildDirectoryPath}/Makefile-libbz2_so",
                        text:       "CC=gcc",
                        newText:    "CC=gcc -m32")

        makeSource( arguments:  "-f Makefile-libbz2_so",
                    path:       buildDirectoryPath)

        makeSource( arguments:  "Makefile-libbz2.a",
                    path:       buildDirectoryPath)
    end

    def buildx32Bits

        makeSource( arguments:  "clean",
                    path:       buildDirectoryPath)

        fileReplaceText(path:       "#{buildDirectoryPath}/Makefile",
                        text:       "CC=gcc",
                        newText:    "CC=gcc -mx32")

        fileReplaceText(path:       "#{buildDirectoryPath}/Makefile-libbz2_so",
                        text:       "CC=gcc",
                        newText:    "CC=gcc -mx32")

        makeSource( arguments:  "-f Makefile-libbz2_so",
                    path:       buildDirectoryPath)

        makeSource( arguments:  "Makefile-libbz2.a",
                    path:       buildDirectoryPath)
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

        if option("32Bits")
            build32Bits
            prepareInstallation32Bits

            makeLink(   target: "libbz2.so.1.0.8",
                        path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.so",
                        type:   :symbolicLinkByOverwrite)

            makeLink(   target: "libbz2.so.1.0.8",
                        path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1",
                        type:   :symbolicLinkByOverwrite)

            makeLink(   target: "libbz2.so.1.0.8",
                        path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1.0",
                        type:   :symbolicLinkByOverwrite)
        end

        if option("x32Bits")
            buildx32Bits
            prepareInstallationx32Bits

            makeLink(   target: "libbz2.so.1.0.8",
                        path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.so",
                        type:   :symbolicLinkByOverwrite)

            makeLink(   target: "libbz2.so.1.0.8",
                        path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1",
                        type:   :symbolicLinkByOverwrite)

            makeLink(   target: "libbz2.so.1.0.8",
                        path:   "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1.0",
                        type:   :symbolicLinkByOverwrite)
        end

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

    def prepareInstallation32Bits

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32")

        copyDirectory(  "#{buildDirectoryPath}/libbz2.so.1.0.8",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1.0.8")

        copyDirectory(  "#{buildDirectoryPath}/libbz2.a",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib32/libbz2.a")
    end

    def prepareInstallationx32Bits

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32")

        copyDirectory(  "#{buildDirectoryPath}/libbz2.so.1.0.8",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1.0.8")

        copyDirectory(  "#{buildDirectoryPath}/libbz2.a",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/libx32/libbz2.a")
    end

    def install
        super

        if option("32Bits")
            runChmodCommand(arguments:  "0755 /usr/lib32/libbz2.so.1.0.8")
            runChmodCommand(arguments:  "0644 /usr/lib32/libbz2.a")
        end

        if option("x32Bits")
            runChmodCommand(arguments:  "0755 /usr/libx32/libbz2.so.1.0.8")
            runChmodCommand(arguments:  "0644 /usr/libx32/libbz2.a")
        end

        runLdconfigCommand
    end

end
