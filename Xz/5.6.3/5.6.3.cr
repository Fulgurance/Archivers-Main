class Target < ISM::Software

    def configure
        super

        if option("Pass1")
            configureSource(arguments:  "--prefix=/usr                      \
                                        --host=#{Ism.settings.chrootTarget} \
                                        --build=$(build-aux/config.guess)   \
                                        --disable-static                    \
                                        --docdir=/usr/share/doc/xz-5.6.3",
                            path:       buildDirectoryPath)
        else
            configureSource(arguments:  "--prefix=/usr      \
                                        --disable-static    \
                                        --docdir=/usr/share/doc/xz-5.6.3",
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
