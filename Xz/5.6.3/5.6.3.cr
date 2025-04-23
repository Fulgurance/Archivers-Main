class Target < ISM::Software

    def configure
        super

        if option("Pass1")
            configureSource(arguments:  "--prefix=/usr                          \
                                        --host=#{Ism.settings.chrootTarget}     \
                                        --build=#{Ism.settings.chrootTarget}    \
                                        --disable-static                        \
                                        --disable-doc",
                            path:       buildDirectoryPath)
        else
            configureSource(arguments:  "--prefix=/usr      \
                                        --disable-static    \
                                        --disable-doc",
                            path:       buildDirectoryPath)
        end
    end

    def build
        super

        makeSource(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        makeSource( arguments:   "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        if option("Pass1")
            deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/lib/liblzma.la")
        end
    end

end
