import React from 'react';
import BlogPostPage from '@theme-original/BlogPostPage';
import Giscus from '@giscus/react';
import { useLocation } from '@docusaurus/router';

export default function BlogPostPageWrapper(props) {
  const { pathname } = useLocation();
  const isCamino = pathname.startsWith('/writing/camino/');

  return (
    <>
      <BlogPostPage {...props} />
      {isCamino && (
        <div style={{ maxWidth: '800px', margin: '2rem auto', padding: '0 1rem' }}>
          <Giscus
            repo="adamliechty/writing"
            repoId="R_kgDOJlSkMA"
            category="General"
            categoryId="DIC_kwDOJlSkMM4DAYgE"
            mapping="pathname"
            strict="0"
            reactionsEnabled="1"
            emitMetadata="0"
            inputPosition="top"
            theme="preferred_color_scheme"
            lang="en"
            loading="lazy"
          />
        </div>
      )}
    </>
  );
}
