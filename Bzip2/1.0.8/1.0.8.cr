class Target < ISM::Software

    def prepare
        super

        fileReplaceText("#{buildDirectoryPath(false)}/Makefile",
                        "ln -s -f $(PREFIX)/bin/",
                        "ln -s -f ")
        fileReplaceText("#{buildDirectoryPath(false)}/Makefile",
                        "$(PREFIX)/man",
                        "$(PREFIX)/share/man")

        makeSource( ["-f","Makefile-libbz2_so"],
                    path: buildDirectoryPath)
        makeSource( ["clean"],
                    path: buildDirectoryPath)

        deleteFile("#{buildDirectoryPath(false)}/libbz2.so.1.0")
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def build32Bits

        makeSource( ["clean"],
                    path: buildDirectoryPath)

        fileReplaceText("#{buildDirectoryPath(false)}/Makefile",
                        "CC=gcc",
                        "CC=gcc -m32")
        fileReplaceText("#{buildDirectoryPath(false)}/Makefile-libbz2_so",
                        "CC=gcc",
                        "CC=gcc -m32")

        makeSource( ["-f","Makefile-libbz2_so"],
                    path: buildDirectoryPath)
        makeSource( ["Makefile-libbz2.a"],
                    path: buildDirectoryPath)
    end

    def buildx32Bits

        makeSource( ["clean"],
                    path: buildDirectoryPath)

        fileReplaceText("#{buildDirectoryPath(false)}/Makefile",
                        "CC=gcc",
                        "CC=gcc -mx32")
        fileReplaceText("#{buildDirectoryPath(false)}/Makefile-libbz2_so",
                        "CC=gcc",
                        "CC=gcc -mx32")

        makeSource( ["-f","Makefile-libbz2_so"],
                    path: buildDirectoryPath)
        makeSource( ["Makefile-libbz2.a"],
                    path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource(["PREFIX=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr","install"],buildDirectoryPath)

        copyFile(   Dir["#{buildDirectoryPath(false)}/libbz2.so.*"],
                    "#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/lib")

        copyFile(   "#{buildDirectoryPath(false)}/bzip2-shared",
                    "#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/bin/bzip2")

        deleteFile("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/lib/libbz2.a")

        if option("32Bits")
            build32Bits
            prepareInstallation32Bits

            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib32/libbz2.so",:symbolicLinkByOverwrite)
            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1",:symbolicLinkByOverwrite)
            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1.0",:symbolicLinkByOverwrite)
        end

        if option("x32Bits")
            buildx32Bits
            prepareInstallationx32Bits

            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/libx32/libbz2.so",:symbolicLinkByOverwrite)
            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1",:symbolicLinkByOverwrite)
            makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1.0",:symbolicLinkByOverwrite)
        end

        deleteFile("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/bin/bzcat")
        deleteFile("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/bin/bunzip2")

        makeLink("libbz2.so.1.0.8","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib/libbz2.so",:symbolicLink)
        makeLink("bzip2","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/bin/bzcat",:symbolicLinkByOverwrite)
        makeLink("bzip2","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/bin/bunzip2",:symbolicLinkByOverwrite)
    end

    def prepareInstallation32Bits

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib32")

        copyDirectory(  "#{buildDirectoryPath(false)}/libbz2.so.1.0.8",
                        "#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1.0.8")

        copyDirectory(  "#{buildDirectoryPath(false)}/libbz2.a",
                        "#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib32/libbz2.a")
    end

    def prepareInstallationx32Bits

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/libx32")

        copyDirectory(  "#{buildDirectoryPath(false)}/libbz2.so.1.0.8",
                        "#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1.0.8")

        copyDirectory(  "#{buildDirectoryPath(false)}/libbz2.a",
                        "#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/libx32/libbz2.a")
    end

    def install
        super

        if option("32Bits")
            setPermissions("#{Ism.settings.rootPath}/usr/lib32/libbz2.so.1.0.8",0o755)
            setPermissions("#{Ism.settings.rootPath}/usr/lib32/libbz2.a",0o644)
        end

        if option("x32Bits")
            setPermissions("#{Ism.settings.rootPath}/usr/libx32/libbz2.so.1.0.8",0o755)
            setPermissions("#{Ism.settings.rootPath}/usr/libx32/libbz2.a",0o644)
        end
    end

end
